
#######################
# Auxiliary functions #
#######################

# Map calls: mutations to CNA segments
map_calls = function(CNA_calls, mutation_calls, samples, purities, sample_id)
{
  cli::clu
  
  sample = samples[sample_id]
  purity = purities[sample_id]
  
  # Diploid segments with at least 500 SNVs
  CNA_calls = CNA_calls %>% select(chr, from, to, starts_with(sample))
  colnames(CNA_calls)[4:5] = c('minor', 'Major')
  
  SNV_calls = mutation_calls %>% select(chr, from, to, ref, alt, starts_with(sample), -ends_with('_N.VAF'))
  colnames(SNV_calls)[6:8] = c('DP', 'NV', 'VAF')
  
  # Use CNAqc to map mutations to segments
  init(snvs = SNV_calls, cna = CNA_calls, purity = purity)
}

# Plot CNA segments and VAF distributions 
plot_calls = function(samples, CNA_calls, mutation_calls, purities)
{
  CNAqc_objects = lapply(
    seq(samples),
    map_calls,
    CNA_calls = CNA_calls,
    mutation_calls = mutation_calls,
    samples = samples,
    purities = purities
  )
  names(CNAqc_objects) = samples
  
  # Comparative CNA plot
  plot_cna = CNAqc::plot_multisample_CNA(CNAqc_objects)
  
  plot_snvs = lapply(samples,
                     function(x) {
                       CNAqc::plot_data_histogram(CNAqc_objects[[x]]) +
                         xlim(0.05, 1) +
                         labs(title = x)
                     }
                     
  )
  
  # Assemble figure: CNA (all) and diploid mutations (right)
  ggarrange(plot_cna,
            ggarrange(
              plotlist = plot_snvs,
              ncol = ceiling(length(plot_snvs)/2),
              nrow = 2
            ),
            ncol = 2)
}

# Run MOBSTER on a list of samples, using mutation data
fit_mobsters = function(mutations, samples)
{
  # Set the seed
  set.seed(123456)
  
  mobster_fits = lapply(
    samples,
    function(x)
    {
      SNV_calls = mutations %>%
        select(chr, from, to, ref, alt, starts_with(!!x), -ends_with('_N.VAF')) 
      
      colnames(SNV_calls)[6:8] = c('DP', 'NV', 'VAF')
      
      mobster_fit(
        SNV_calls %>% filter(VAF > 0.05),
        description = x,
        parallel = FALSE,
        K = 1:2,
        init = 'peaks',
        model.selection = 'ICL',
        samples = 1,
        maxIter = 150,
        epsilon = 1e-6
      )$best
    })
  names(mobster_fits) = samples
  
  return(mobster_fits)
}

# Get ids for tail mutations
get_nontail_mutations = function(mutations, mobster_fits)
{
  # Clusters, retain non-tail mutations
  non_tail_mutations = lapply(names(mobster_fits),
                              function(x)
                                mobster::Clusters(mobster_fits[[x]]) %>%
                                mutate(id = paste(chr, from, to, ref, alt, sep = ':')) %>%
                                select(id, cluster) %>%
                                mutate(sample = x))
  
  non_tail_mutations = Reduce(bind_rows, non_tail_mutations) %>%
    spread(id, cluster) %>%
    select(starts_with('chr'))
  
  # Use the mutation id
  ids = colnames(non_tail_mutations)
  ids = ids[apply(non_tail_mutations, 2, function(x) all(x != 'Tail', na.rm = T))]
  
  mutations %>%
    mutate(id = paste(chr, from, to, ref, alt, sep = ':')) %>%
    filter(id %in% ids)
}

# Return a set of colors for VIBER clusters, using the wesanderson palettes
get_cluster_colors = function(palettes, viber_fit)
{
  # Get 5 nice colours from the 
  colors = sapply(palettes, wesanderson::wes_palette) %>% as.vector
  
  non_zero_clusters = which((viber_fit$pi_k * viber_fit$N) %>% round > 0) %>% names
  names(colors) = non_zero_clusters
  
  colors
}

# Squared complex plot
squareplot = function(mobster_fits, viber_fit_bottom, viber_fit_top, samples_list, colors_bottom, colors_top)
{
  row_plots = NULL
  for (s in seq(samples_list))
  {
    sn = samples_list[s]
    mb = list(plot(mobster_fits[[sn]]) + labs(title = sn) )
    
    idx_pre = 1:s
    idx_post = s:length(samples_list)
    
    pl_r = pl_l = NULL
    
    if (length(idx_pre) > 1)
      pl_r = lapply(setdiff(idx_pre, s), function(x) {
        VIBER::plot_2D(viber_fit_bottom, d1 = sn, d2 = samples_list[x], colors = colors_bottom)
      })
    
    if (length(idx_post) > 1)
      pl_l = lapply(setdiff(idx_post, s), function(x) {
        VIBER::plot_2D(viber_fit_top, d1 = sn, d2 = samples_list[x], colors = colors_top)
      })
    
    row_plot = cowplot::plot_grid(
      plotlist = append(append(pl_r, mb), pl_l),
      nrow = 1,
      ncol = length(pl_r) + length(pl_l) + 1,
      align = 'h',
      axis = 'x'
    )
    
    row_plots = append(row_plots, list(row_plot))
  }
  
  cowplot::plot_grid(
    plotlist = row_plots,
    ncol = 1,
    nrow = length(row_plots),
    align = 'v'
  )
}
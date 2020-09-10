MOBSTER: Source Data
================
Giulio Caravagna
24/5/2020

-----

<center>

<a href="https://caravagn.github.io/mobster"><img src="https://caravagn.github.io/mobster/reference/figures/logo.png" width=77px height=91px></img></a>
<a href="https://caravagn.github.io/VIBER"><img src="https://caravagn.github.io/VIBER/reference/figures/logo.png" width=77px height=91px></img></a>
<a href="https://caravagn.github.io/BMix"><img src="https://caravagn.github.io/BMix/reference/figures/logo.png" width=77px height=91px></img></a>
<a href="https://caravagn.github.io/CNAqc"><img src="https://caravagn.github.io/CNAqc/reference/figures/logo.png" width=77px height=91px></img></a>
<a href="https://t-heide.github.io/TEMULATOR"><img src="https://t-heide.github.io/TEMULATOR/reference/figures/logo.png" width=77px height=91px></img></a>

</center>

-----

This is the material released with the paper:

  - *Subclonal reconstruction of tumors using machine learning and
    population genetics*. Giulio Caravagna, Timon Heide, Marc Williams,
    Luis Zapata, Daniel Nichol, Ketevan Chkhaidze, William Cross, George
    D. Cresswell, Benjamin Werner, Ahmet Acar, Chris P. Barnes, Guido
    Sanguinetti, Trevor A. Graham, Andrea Sottoriva. Nature Genetics 52, 898–907 (2020).

The following R packages are required to run the analyses.

  - [MOBSTER](https://caravagn.github.io/mobster), to cluster the tumour
    site frequency spectrum with Beta and Pareto distributions;
  - [BMix](https://caravagn.github.io/BMix) and
    [VIBER](https://caravagn.github.io/VIBER), to model read counts data
    with Binomial mixtures;
  - [CNAqc](https://caravagn.github.io/CNAqc), to integrate mutation and
    copy number data from bulk sequencing;
  - [TEMULATOR](https://t-heide.github.io/TEMULATOR/), to simulated
    non-spatial tumour growth dynamics;
  - [CHESS](https://github.com/sottorivalab/CHESS.cpp), to simulated
    spatial tumour growth dynamics;

-----

The vignettes are rendered in HTML. To visualise them correctly it is
best to open the HTML files locally with your browser. As an
alternative, you can [use a preview
website](https://htmlpreview.github.io/).

**Note** that vignettes 6 and 7 use `DT` tables ad cannot be rendered by
the preview website.

  - [MOBSTER](https://caravagn.github.io/mobster) (version `0.1.1`)
    installable sources are available in folder
    `R_package`.

<!-- end list -->

    install.packages("./R_package/mobster_0.1.1.tar.gz, repos = NULL, type = 'sources', dependencies = TRUE)

**1. [Example subclonal
dynamics](https://caravagn.github.io/mobster/articles/Example_tumour_simulation.html).**
Simulated example of tumour subclonal evolution with snapshots of tumour
dynamics at different timepoints, and MOBSTER analysis (hosted at
[MOBSTER](https://caravagn.github.io/mobster) website).

**2. [Simulated single-sample data
analysis](http://htmlpreview.github.io/?https://github.com/caravagn/mobster_supp_data/blob/master/Tumor_sim_nospace/Simulated_onesample.html).**
`n = 150` cases with `0` or `1` subclone, with simulated WGS at median
coverage 120x. Mutation calls are simulated without copy num data; the
coverage is Poisson-distributed.

**3. [Simulated multi-sample data
analysis](http://htmlpreview.github.io/?https://github.com/caravagn/mobster_supp_data/blob/master/Tumor_sim_space/Simulated_multisample.html).**
`n = 15` cases of spatially growing tumours (2D) with `0`, `1` or `2`
subclones, with simulated WGS at median coverage 120x. Mutation calls
are simulated without copy num data; the coverage is
Poisson-distributed.

**4. [Single-sample cross-sectional lung
cases](http://htmlpreview.github.io/?https://github.com/caravagn/mobster_supp_data/blob/master/Lungs/Real_data_lungs.html).**
`n = 2` lung cancer cases with `0` subclones, with WGS at median
coverage ~100x. Mutation calls are and copy num data are available from
the [COALA](http://genome.kaist.ac.kr/). Code in this vignette can be
used also to re-analyse the breast and AML case samples that we discuss
in the paper (see the papers for data availability).

**5. [Multi-region cross-sectional colorectal
carcinomas](http://htmlpreview.github.io/?https://github.com/caravagn/mobster_supp_data/blob/master/CRC/CRC_vignette.html).**
2 colorectal cancer cases with multiple biopsies each, with WGS at
median coverage ~100x. These are new data first released with this
paper. Code in this vignette can be used also to replicate the results
that we discuss in the paper; a further vignette is available to
[replicate Supplementary
Figures](http://htmlpreview.github.io/?https://github.com/caravagn/mobster_supp_data/blob/master/CRC/CRC_vignette_SM.html).

**6. [PCAWG
analysis](http://htmlpreview.github.io/?https://github.com/caravagn/mobster_supp_data/blob/master/PCAWG/PCAWG_analysis_table.html).**
Summary statistics for `n = 2566` cases of different cancers
(pan-cancer). This cohort has WGS single-samples with coverage ~45x.
Mutation and copy number calls that we used have been generated by the
PCAWG consortium.

**7. [GBM
analysis](http://htmlpreview.github.io/?https://github.com/caravagn/mobster_supp_data/blob/master/GBM/GBM_analysis_table.html).**
Summary statistics for `n = 71` longitudinal GBM biopsies This cohort
has WGS primary/ relapse samples with coverage ~100x. Mutation and copy
number calls that we used have been generated by the orugunal authors

-----

Contacts: Giulio Caravagna, PhD. *Institute of Cancer Research, London,
UK*.

[![](https://img.shields.io/badge/Email-gcaravagn@gmail.com-informational.svg?style=social)](mailto:gcaravagn@gmail.com)
[![](https://img.shields.io/badge/caravagn-informational.svg?style=social&logo=GitHub)](https://github.com/caravagn)
[![](https://img.shields.io/badge/@gcaravagna-informational.svg?style=social&logo=Twitter)](https://twitter.com/gcaravagna)
[![](https://img.shields.io/badge/Homepage-informational.svg?style=social&logo=Google)](https://sites.google.com/site/giuliocaravagna/)

# Studying word meanings through the eyes

This is the repo for a talk I'm giving at the McPherson Eye Research Institute's Research-at-a-glance event.

## Papers

[Edmiston & Lupyan (2015). What makes words special? Words as unmotivated cues. _Cognition_.](http://sapir.psych.wisc.edu/papers/edmiston_lupyan_2015_motivated.pdf)  
[Edmiston & Lupyan (2016). Visual interference disrupts visual knowledge. _Journal of Memory and Language_.](http://sapir.psych.wisc.edu/papers/edmiston_lupyan_JML.pdf)

## Experiments

For the materials, data, and analyses, check out the following github repos.

<https://github.com/lupyanlab/motivated-cues>  
<https://github.com/lupyanlab/property-verification>  
<https://github.com/lupyanlab/orientation-discrimination>

## Data

If you just want data, it's available in R packages (wrappers around the data and associated functions) that can be installed from github.

```R
library(devtools)
install_github("lupyanlab/motivated-cues", subdir = "motivatedcues")
install_github("lupyanlab/property-verification", subdir = "propertyverificationdata")
install_github("lupyanlab/orientation-discrimination", subdir = "orientationdiscrimination")
```

## Build

To build the presentation, you need reveal.js, which is referenced in this project as a git submodule. To save the slides as pdf, you need decktape, which is also included as a submodule. To download the required submodules, clone this repo and run the following commands:

```bash
git submodule init
git submodule update
./build -o   # build to html and open the presentation
./build -po  # build to html then to pdf and then open it
```

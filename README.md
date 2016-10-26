# Studying word meanings through the eyes

## Data

The data presented in this talk is available as a set of R packages that can be installed from github.

```R
library(devtools)
install_github("lupyanlab/motivated-cues",
               subdir = "motivatedcues")
install_github("lupyanlab/property-verification",
               subdir = "propertyverificationdata")
install_github("lupyanlab/orientation-discrimination",
               subdir = "orientationdiscrimination")
```

## Build

To build the presentation, you need reveal.js, which is referenced in this project as a git submodule. To save the slides as pdf, you need decktape, which is also included as a submodule. To download the required submodules, clone this repo and run the following commands:

```bash
git submodule init
git submodule update
./build -o   # build to html and open the presentation
./build -po  # build to html then to pdf and then open it
```

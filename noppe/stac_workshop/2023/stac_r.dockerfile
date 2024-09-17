# Use Rocker RStudio as base for your image
FROM rocker/rstudio

# copy the desired installation script into docker file system, make sure that you have execute rights to the script
COPY install_geospatial_stac.sh /rocker_scripts/

# install the custom packages and system dependencies by running the script
RUN /rocker_scripts/install_geospatial_stac.sh


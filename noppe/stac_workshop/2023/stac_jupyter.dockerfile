# use jupyter minimal notebook as base for your image
# it has eg conda already installed
FROM jupyter/minimal-notebook

#some first setup steps need to be run as root user
USER root

# set home environment variable to point to user directory
ENV HOME /home/$NB_USER

# install needed extra tools, eg ssh-client and less
RUN apt-get update \
    && apt-get install -y ssh-client less \
    && apt-get clean

# the user set here will be the user that students will use 
USER $NB_USER

### Installing the needed conda packages and jupyter lab extensions. 
# Run conda clean afterwards in same layer to keep image size lower
RUN conda install --yes -c conda-forge pyproj requests dask stackstac pystac-client pystac geopandas gdal \
    &&  rioxarray json rasterio conda clean -afy

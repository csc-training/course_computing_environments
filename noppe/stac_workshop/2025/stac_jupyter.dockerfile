# use jupyter minimal notebook as base for your image
# it has eg conda already installed
FROM quay.io/jupyter/minimal-notebook:2025-03-05

#some first setup steps need to be run as root user
USER root

# set home environment variable to point to user directory
ENV HOME=/home/$NB_USER

# Make sure user home directory is owned by user (sometimes there could be a .cache directory owned by root)
RUN chown -R $NB_USER $HOME

# install needed extra tools, eg ssh-client and less
RUN apt-get update \
    && apt-get install -y ssh-client less \
    && apt-get clean

# the user set here will be the user that students will use 
USER $NB_USER

### Installing the needed conda packages and jupyter lab extensions. 
# Run conda clean afterwards in same layer to keep image size lower
RUN conda install --yes -c conda-forge pyproj requests dask stackstac pystac-client pystac geopandas gdal \
    rioxarray rasterio libgdal-jp2openjpeg jupyter-resource-usage dask-labextension python-graphviz \
    && conda clean -afy

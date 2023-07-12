FROM jupyter/minimal-notebook:python-3.10

USER root

# install needed extra tools, eg ssh-client and less
RUN apt-get update \
    && apt-get install -y ssh-client less libgl1-mesa-dev xvfb \
    && apt-get clean
    
USER $NB_USER

### Installing the needed conda packages and jupyter lab extensions. 
# Run conda clean afterwards in same layer to keep image size lower
RUN conda install --yes -c conda-forge pip geemap pyntcloud \
  && conda clean -afy && pip install ipygany pyvista laspy[lazrs,laszip] 
  
RUN jupyter nbextension enable --py --sys-prefix ipygany && jupyter labextension install @jupyter-widgets/jupyterlab-manager ipygany

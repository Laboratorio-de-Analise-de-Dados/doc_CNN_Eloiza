FROM python:3.7.9

LABEL maintainer="Guilherme F Silveira"

WORKDIR /usr/src/myapp

COPY ./python_req.txt /usr/src/myapp

RUN pip install --upgrade pip && \
    pip install -r python_req.txt && \ 
    apt-get update && \
    # Instrução de instalções para exportar o notebook para pdf
    apt-get install -y pandoc && \ 
    apt-get install -y texlive-xetex texlive-fonts-recommended texlive-plain-generic

COPY . /usr/src/myapp

COPY ./JupyterLab-configs/tracker.jupyterlab-settings /root/.jupyter/lab/user-settings/@jupyterlab/notebook-extension/tracker.jupyterlab-settings
COPY ./JupyterLab-configs/themes.jupyterlab-settings /root/.jupyter/lab/user-settings/@jupyterlab/apputils-extension/themes.jupyterlab-settings
COPY ./JupyterLab-configs/plugin.jupyterlab-settings /root/.jupyter/lab/user-settings/@jupyterlab/docmanager-extension/plugin.jupyterlab-settings

EXPOSE 8888
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root"]
FROM jupyter/scipy-notebook

ARG conda_env=python37
ARG py_ver=3.7

RUN conda create --quiet --yes -p "${CONDA_DIR}/envs/${conda_env}" python=${py_ver} ipython ipykernel && \
    conda clean --all -f -y
RUN "${CONDA_DIR}/envs/${conda_env}/bin/python" -m ipykernel install --user --name="${conda_env}" && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

ENV PATH "${CONDA_DIR}/envs/${conda_env}/bin:${PATH}"
ENV CONDA_DEFAULT_ENV ${conda_env}


COPY requirements.txt requirements.txt

RUN "${CONDA_DIR}/envs/${conda_env}/bin/pip" install -r requirements.txt
# RUN pip3 install -r requirements.txt

WORKDIR /home/

CMD [ "jupyter", "notebook" ]]

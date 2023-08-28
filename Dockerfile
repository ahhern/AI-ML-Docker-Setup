FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive

# basic package install
RUN apt-get update && apt-get install -y software-properties-common
RUN apt-get update && apt-get install -y \
	build-essential \
	curl \
	ca-certificates \
	sudo \
	git \
	vim \
	wget \
	bzip2 \
	python3-dev \
	python3-pip \
	python3-tk \
	libjpeg-dev \
	libpng-dev && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

#RUN curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -

# Download and install Miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh \
    && chmod +x miniconda.sh \
    && ./miniconda.sh -b -p /opt/conda \
    && rm miniconda.sh

# Set Conda to your PATH environment variable
ENV PATH="/opt/conda/bin:$PATH"

# Install Node.js
RUN conda install -c conda-forge nodejs

# install pip and AI/ML packages
RUN sudo python3 -m pip install pip --upgrade
RUN sudo python3 -m pip install numpy pandas scipy statsmodels mlxtend probscale matplotlib seaborn plotly bokeh pydot scikit-learn xgboost lightgbm catboost eli5 tensorflow keras theano nltk spacy gensim scrapy pybrain jupyterlab torch torchvision sympy pytest ipympl

# No need for this , since JupyterLab is >= 3 today.  See https://www.npmjs.com/package/jupyter-matplotlib
#RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager jupyter-matplotlib

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

# setup user
RUN adduser --disabled-password --gecos '' --shell /bin/bash user
RUN echo "user ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/90-user
USER user

ENV HOME=/home/user
RUN chmod 777 /home/user

#expose ports for jupyter lab and tensorboard
EXPOSE 6006
EXPOSE 8888

WORKDIR /home/user

COPY start_jupyter.sh start_jupyter.sh

CMD ["/bin/bash"]
#ENTRYPOINT ["jupyter", "lab"]

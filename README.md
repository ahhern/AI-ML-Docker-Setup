# AI-ML-Docker-Setup
Vanilla Docker Setup for AI/ML in python.


## Setup 
Download and install Docker on your machine: https://docs.docker.com/get-started/

## Install Machine
Once you have installed Docker installed, use the script provided to run the installation.

`$ ./setup_docker.sh`

## Run Machine
Once the installation is complete, run the Docker machine using the provided script:

`$ ./run_docker.sh`

## Running Jupyter Labs

Because of an IP configuration issue, in order to run Jupyter labs you will need to run the following command:

`$ jupyter lab --ip=* `

Once running, Jupyter labs will provide you with a URL that looks similar to this:

`http://(456937b722b9 or 127.0.0.1):8888/?token=XYZ`

**Note:** Your "token" parameter will be different. 

In order to access Jupyter Labs, copy the URL the terminal output, including the token, into your browser. 

`http://127.0.0.1:8888/?token=XYZ`

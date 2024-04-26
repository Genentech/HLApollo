# hash:sha256:9a37552344e1eb6c31fd9a3e99ff379592b95741d1e1b7c240a5ee19b6a47fca
FROM registry.codeocean.com/codeocean/miniconda3:4.12.0-python3.9-ubuntu20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        libatlas-base-dev=3.10.3-8ubuntu7 \
    && rm -rf /var/lib/apt/lists/*


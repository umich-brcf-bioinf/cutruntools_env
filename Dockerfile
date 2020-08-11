FROM rocker/verse:4.0.0
RUN apt-get update -y
RUN apt-get install python-dev build-essential libssl-dev libffi-dev libxml2-dev libxslt1-dev zlib1g-dev -y

RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py

WORKDIR /opt/
RUN git clone https://bitbucket.org/qzhudfci/cutruntools.git

WORKDIR /opt/cutruntools/
RUN sh ./atactk.install.sh
RUN sh ./ucsc-tools.install
RUN sh ./make_kseq_test.sh

RUN mkdir -p /usr/share/r_pkgs
RUN Rscript -e "install.packages('CENTIPEDE', repos='http://R-Forge.R-project.org',lib='/usr/share/r_pkgs')"

ENV PATH="/opt/cutruntools/:/opt/cutruntools/macs2.narrow.aug18.dedup/::${PATH}"

FROM centos:7

RUN yum -y install wget centos-release-openstack-rocky

RUN yum -y install python-openstackclient

COPY x509proxy /tmp/x509up_u0

RUN mkdir /usr/local/gridpp-dirac && \
    cd /usr/local/gridpp-dirac && \
    wget -np -O dirac-install https://raw.githubusercontent.com/DIRACGrid/DIRAC/integration/Core/scripts/dirac-install.py && \
    chmod +x dirac-install && \
    ./dirac-install -r v6r20p15 -i 27 -g v14r1 && \
    ls && \
    pwd && \
    source ./bashrc && \
    dirac-configure -F -S GridPP -C dips://dirac01.grid.hep.ph.ic.ac.uk:9135/Configuration/Server -I && \
    rm -f /tmp/x509up_u0 && \
    mv bashrc /etc/profile.d/gridpp-dirac.sh && \
    mv cshrc /etc/profile.d/gridpp-dirac.csh

RUN useradd user

VOLUME /home/user

#
# 
#
FROM centos:7

# Repositories
RUN yum -y install centos-release-openstack-rocky epel-release

# Packages we need or want
RUN yum -y install emacs \
                   joe \
                   less \
                   man \
                   man-pages \
                   man-pages-overrides \
                   nano \
                   python-openstackclient \
                   wget

# Get the x50proxy file from build directory
COPY x509proxy /tmp/x509up_u0

# Install GridPP DIRAC. This gives us the grid clients too.
RUN mkdir /usr/local/gridpp-dirac && \
    cd /usr/local/gridpp-dirac && \
    wget -np -O dirac-install https://raw.githubusercontent.com/DIRACGrid/DIRAC/integration/Core/scripts/dirac-install.py && \
    chmod +x dirac-install && \
    ./dirac-install -r v6r20p15 -i 27 -g v14r1 && \
    source ./bashrc && \
    dirac-configure -F -S GridPP -C dips://dirac01.grid.hep.ph.ic.ac.uk:9135/Configuration/Server -I && \
    rm -f /tmp/x509up_u0 && \
    mv bashrc /etc/profile.d/gridpp-dirac.sh && \
    mv cshrc /etc/profile.d/gridpp-dirac.csh

# Add a non-privileged user
RUN useradd --create-home --skel /dev/null user


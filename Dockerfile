#
#  Andrew McNab, University of Manchester.
#  Copyright (c) 2018. All rights reserved.
#
#  Redistribution and use in source and binary forms, with or
#  without modification, are permitted provided that the following
#  conditions are met:
#
#    o Redistributions of source code must retain the above
#      copyright notice, this list of conditions and the following
#      disclaimer. 
#    o Redistributions in binary form must reproduce the above
#      copyright notice, this list of conditions and the following
#      disclaimer in the documentation and/or other materials
#      provided with the distribution. 
#
#  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
#  CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
#  INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
#  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
#  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
#  BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
#  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
#  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
#  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
#  ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
#  OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
#  OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
#  POSSIBILITY OF SUCH DAMAGE.
#
#  Contacts: Andrew.McNab@cern.ch  https://www.iris.ac.uk
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
    rm -f /tmp/x509up_u0

# Create aliases to enable Grid/DIRAC commands (which change Python version and its libraries)
RUN echo "alias setup-grid='source /usr/local/gridpp-dirac/bashrc'" > /etc/profile.d/gridpp-dirac.sh
RUN echo "alias setup-grid 'source /usr/local/gridpp-dirac/cshrc'" > /etc/profile.d/gridpp-dirac.csh

# Add a non-privileged user
RUN useradd --create-home --skel /dev/null user


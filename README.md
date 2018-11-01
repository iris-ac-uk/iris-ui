# iris-ui
CentOS 7 Docker image with DIRAC, Grid and OpenStack clients


The resulting image contains the following families of clients:

openstack - general purpose OpenStack client for creating images, managing
   VMs etc

dirac-wms-job-submit, dirac-dms-lfn-replicas, etc - commands for managing jobs,
   data files, and replica catalogs through DIRAC (eg the GridPP DIRAC Service)

xrdcp, xrdls etc - commands for interacting with xroot storage services

lcg-cp, lcg-ls etc - WLCG storage commands, including SRMs

davix-get etc - WLCG commands for accessing WebDAV storage services

arcsub, arcproxy etc - commands for managing jobs on ARC Compute Elements, 
   including creating VOMS proxies


To build: clone this repo, put a valid proxy of a member of the GridPP DIRAC
Service into the file x509proxy (no VOMS extensions required) and then execute

make push




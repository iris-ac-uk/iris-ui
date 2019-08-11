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

To enable the Grid and DIRAC commands (which use a different Python version)
execute the command grid-setup.

The editors emacs, nano, joe, and vi are also available.

------

To build: clone this repo, put a valid proxy of a member of the GridPP DIRAC
Service into the file x509proxy (no VOMS extensions required) and then execute

make push

------

To create a container from the image, it is recommended to mount a volume
at /home/user with the files you write. This should make it easier to move
to newer versions of the image whilst retaining your own files.

On Linux or macOS, a command like this may be used to create and enter
an iris-ui Docker container as a non-privileged user:

docker run --user user --tty --interactive \
  --volume $HOME/iris-ui-home:/home/user \
  --workdir /home/user irisacuk/iris-ui:latest /bin/bash --login


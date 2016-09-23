#!/bin/bash

# Generate lists of the base provides of all rpms in CentOS => needed to check if an rpm conflicts with CentOS base

# repoquery --disablerepo="*" --enablerepo="base" --provides -a | sed 's| .*||g;' > /srv/rpmbuild/centos-base-provides

docker run -ti driesrpms/centos7-x86_64:latest repoquery --disablerepo="*" --enablerepo="base" --provides -a | sed 's| .*||g;' > centos7-x86_64-base-provides
docker run -ti driesrpms/centos6-x86_64:latest repoquery --disablerepo="*" --enablerepo="base" --provides -a | sed 's| .*||g;' > centos6-x86_64-base-provides
docker run -ti driesrpms/centos5-x86_64:latest repoquery --disablerepo="*" --enablerepo="base" --provides -a | sed 's| .*||g;' > centos5-x86_64-base-provides



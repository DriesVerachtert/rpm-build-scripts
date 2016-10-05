
FROM centos:centos5
MAINTAINER Dries Verachtert
RUN yum -y update
RUN yum -y install rpm-build redhat-rpm-config yum-utils rpmdevtools git sudo createrepo yum-plugin-priorities
#RUN yum -y groupinstall buildsys-build
RUN yum -y install bash bzip2 coreutils cpio diffutils findutils gawk gcc gcc-c++ grep gzip info make patch redhat-rpm-config rpm-build sed shadow-utils tar unzip util-linux which xz
# python-hashlib is needed for yum to handle newer createrepo generated repositories
# update: not needed: switched to createrepo with checksum sha
# RUN yum -y install python-hashlib
# CentOS 5 useradd does not support -U
RUN groupadd -g 1000 rpmbuild
RUN useradd -u 1000 -c 'RPM build user' -m -g 1000 -d /home/rpmbuild rpmbuild
#RUN echo "rpmbuild ALL=(ALL)       NOPASSWD: ALL" > /etc/sudoers.d/rpmbuild
# CentOS 5 doesn't use a /etc/sudoers.d/ directory
RUN echo "Cmnd_Alias RPMBUILDING = /usr/bin/yum-builddep, /home/rpmbuild/rpmforge/repoforge-t_functional/runtests.sh" >> /etc/sudoers
RUN echo "rpmbuild   ALL= NOPASSWD: RPMBUILDING" >> /etc/sudoers
RUN echo "Defaults!RPMBUILDING !requiretty" >> /etc/sudoers

ADD rpmmacros /home/rpmbuild/.rpmmacros
RUN chown rpmbuild:rpmbuild /home/rpmbuild/.rpmmacros
ADD curlrc /home/rpmbuild/.curlrc
RUN chown rpmbuild:rpmbuild /home/rpmbuild/.curlrc
ADD local.repo /etc/yum.repos.d/local.repo
RUN chown root:root /etc/yum.repos.d/local.repo
ADD dries5.repo /etc/yum.repos.d/dries5.repo
RUN chown root:root /etc/yum.repos.d/dries5.repo
RUN mkdir -p /home/rpmbuild/repo && cd /home/rpmbuild/repo && createrepo . && chown -R rpmbuild:rpmbuild .

#VOLUME /home/rpmbuild/rpm

RUN yum install -y http://mirror.hmc.edu/rpmforge/redhat/el5/en/x86_64/buildtools/RPMS/rpm-macros-rpmforge-0-6.el5.rfb.noarch.rpm

USER 1000
WORKDIR /home/rpmbuild


FROM centos:centos6
MAINTAINER Dries Verachtert
RUN yum -y install rpm-build redhat-rpm-config yum-utils rpmdevtools git sudo createrepo yum-plugin-priorities
RUN yum -y install bash bzip2 coreutils cpio diffutils findutils gawk gcc gcc-c++ grep gzip info make patch redhat-rpm-config rpm-build sed shadow-utils tar unzip util-linux which xz
RUN yum -y install scl-utils-build
RUN yum -y update

RUN useradd -u 1000 -c 'RPM build user' -m -U -d /home/rpmbuild rpmbuild
#RUN echo "rpmbuild ALL=(ALL)       NOPASSWD: ALL" > /etc/sudoers.d/rpmbuild
RUN echo "Cmnd_Alias RPMBUILDING = /usr/bin/yum-builddep, /home/rpmbuild/rpmforge/repoforge-t_functional/runtests.sh" > /etc/sudoers.d/rpmbuild
RUN echo "rpmbuild   ALL= NOPASSWD: RPMBUILDING" >> /etc/sudoers.d/rpmbuild
RUN echo "Defaults!RPMBUILDING !requiretty" >> /etc/sudoers.d/rpmbuild

ADD rpmmacros /home/rpmbuild/.rpmmacros
RUN chown rpmbuild:rpmbuild /home/rpmbuild/.rpmmacros
ADD curlrc /home/rpmbuild/.curlrc
RUN chown rpmbuild:rpmbuild /home/rpmbuild/.curlrc
ADD local.repo /etc/yum.repos.d/local.repo
RUN chown root:root /etc/yum.repos.d/local.repo
ADD dries-scl-untested-6-x86_64.repo /etc/yum.repos.d/dries-scl-untested-6-x86_64.repo
RUN chown root:root /etc/yum.repos.d/dries-scl-untested-6-x86_64.repo
RUN mkdir -p /home/rpmbuild/repo && cd /home/rpmbuild/repo && createrepo . && chown -R rpmbuild:rpmbuild .

#VOLUME /home/rpmbuild/rpm

RUN yum install -y http://mirror.hmc.edu/rpmforge/redhat/el6/en/x86_64/buildtools/RPMS/rpm-macros-rpmforge-0-6.el6.rfb.noarch.rpm
RUN yum -y install epel-release

USER 1000
WORKDIR /home/rpmbuild

#!/bin/bash

# normally executed within a docker build image
# argument 1: a single rpm to test
# argument 2: a path to a 'centos-base-provides' file

CONFLICTSFOUND=0

if [[ -n "$1" ]] ; then
	MYRPM=$1
	if [[ -n "$2" ]] ; then
		MYBASEPROVIDES=$2
		echo "start of check-single-rpm-for-conflicts-with-centos-base.sh"
		echo "MYRPM: $MYRPM"
		echo "MYBASEPROVIDES: $MYBASEPROVIDES"
		for i in `rpm -q --provides -p $MYRPM | sed 's| .*||g;'`; do
			grep -q -x -F "$i" $MYBASEPROVIDES
			MYGREPRETVAL=$?
			if [[ $MYGREPRETVAL -eq 1 ]] ; then
				echo "No conflict found for $i"
			else
				if [[ $MYGREPRETVAL -eq 0 ]] ; then
					echo "Conflict found: $i is already provided by a CentOS base rpm: " `repoquery  --disablerepo="*" --enablerepo="base" --whatprovides "$i"`
					CONFLICTSFOUND=1
				else
					echo "Error occurred while checking provides"
					exit 1
				fi
			fi
		done
	else
		echo "Argument 2 neede: a list of base provides of a certain CentOS release, for example /srv/rpmbuild/centos6-x86_64-base-provides"
		exit 1
else
	echo "Argument 1 needed: an rpm, for example /path/to/aget-1.2.3-1.x86_64.rpm"
	exit 1
fi

if [[ $CONFLICTSFOUND -eq 1 ]]; then
	exit 1
fi

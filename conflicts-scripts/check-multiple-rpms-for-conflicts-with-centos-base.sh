#!/bin/bash

# check if the rpms found after a build are conflicting with CentOS base
# argument: a build directory, that contains rpms like 'x86_64/aget-1.2-3.x86_64.rpm'
# environment variable: BASEPROVIDESFILE, with a list of base provides such as /srv/rpmbuild/centos6-x86_64-base-provides
# reason of the environment variable instead of an argument: jenkins uses directories with spaces => not that easy to use multiple arguments
# expects to find the script that checks a single rpm in the same directory

# TODO: use something like popt so everything can be passed as arguments

echo "start of check-multiple-rpms-for-conflicts-with-centos-base.sh"

if [[ -n "$BASEPROVIDESFILE" ]] ; then
	echo "BASEPROVIDESFILE: $BASEPROVIDESFILE"
else 
	echo "BASEPROVIDESFILE environment variable missing!"
	exit 1
fi
MYSCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SINGLERPMSCRIPT=$MYSCRIPTDIR/check-single-rpm-for-conflicts-with-centos-base.sh

OVERALRETVAL=0

cd "$@"
echo "pwd is:"
pwd

for someRpm in */*.rpm
do
	echo "someRpm: $someRpm"
	if [[ "$someRpm" != *.src.rpm ]]; then 
		$SINGLERPMSCRIPT $someRpm $BASEPROVIDESFILE
		if [[ $? > 1 ]] ; then
			OVERALRETVAL=1
		fi
	fi
done

if [[ $OVERALRETVAL -eq 1 ]]; then
	exit 1
fi

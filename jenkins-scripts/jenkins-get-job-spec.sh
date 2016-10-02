#!/bin/bash

# get the current job specification xml of a certain job

JOB_NAME='aget aget.spec centos7-x86_64 el7'

JENKINS_URL=https://jenkins.driesrpms.eu
JENKINS_SSH_KEY=/srv/rpmbuild/scripts/jenkins-script-sshkey/dries-jenkins-cli-key-id_rsa
JENKINS_CLI_JAR=/var/cache/jenkins/war/WEB-INF/jenkins-cli.jar

java -jar $JENKINS_CLI_JAR -i $JENKINS_SSH_KEY -s $JENKINS_URL get-job "$JOB_NAME"

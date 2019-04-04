#!/bin/sh
# Wrapper script for docker.
#
# This is used primarily for wrapping the GNU Make workflow.
# Instead of typing "make TARGET", type "./run.sh make TARGET".
# This will run the make workflow within a docker container.
#
# The assumption is that you are working in the src/ontology folder;
# we therefore map the whole repo (../..) to a docker volume.
#
# See README-editors.md for more details.

set -x
sudo apt-get install -y software-properties-common
sudo add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe restricted multiverse"
sudo apt-get update
sudo apt install moreutils

docker run --memory=8g -e ROBOT_JAVA_ARGS=-Xmx7G -v $PWD/../../:/work -w /work/src/ontology --rm -ti obolibrary/odkfull "$@" | ts -s %M:%S

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

docker run --memory=8g -e ROBOT_JAVA_ARGS=-Xmx7G -v $PWD/../../:/work -w /work/src/ontology --name mondo_test -ti obolibrary/odkfull bash
docker ps --no-trunc
docker exec mondo_test apk add moreutils
docker exec mondo_test  "$@" | ts -s %M:@%S
sleep 10
docker exec mondo_test  "$@" | ts -s %M:@%S
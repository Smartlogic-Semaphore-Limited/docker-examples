#!/bin/sh

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

source $SCRIPTPATH/CheckJava.sh


cd $SCRIPTPATH/..

$SHELL $SCRIPTPATH/../solr/bin/solr $@


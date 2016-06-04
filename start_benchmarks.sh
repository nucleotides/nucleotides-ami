#!/bin/bash

set -o nounset

DATA='http://169.254.169.254/latest/user-data/'

NUCLEOTIDES_API=$(curl -s ${DATA} | jq --raw-output '.environment.NUCLEOTIDES_API')
NUCLEOTIDES_S3_URL=$(curl -s ${DATA} | jq --raw-output '.environment.NUCLEOTIDES_S3_URL')

TASKS=$1

export NUCLEOTIDES_API
export NUCLEOTIDES_S3_URL
parallel \
        --no-notice \
        --max-procs 1 \
        --env NUCLEOTIDES_API \
        --env NUCLEOTIDES_S3_URL \
        "nucleotides all {}" \
        ::: ${TASKS}

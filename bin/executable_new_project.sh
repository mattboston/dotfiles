#!/bin/bash

PROJECT_FOLDER=~/Development
PROJECT=$1
WORKSPACE=${PROJECT}.code-workspace

mkdir -p ${PROJECT_FOLDER}/${PROJECT}
cd ${PROJECT_FOLDER}/${PROJECT}
cat > ${WORKSPACE} <<- EOF
{
    "folders": [
        {
            "path": "."
        }
    ],
    "settings": {}
}
EOF
#""" > ${PROJECT}.code-workspace
#open -a "Visual Studio Code" ${PROJECT}.code-workspace
#code -n ${PROJECT}.code-workspace
#code -n ..
#open -n ${PROJECT}.code-workspace

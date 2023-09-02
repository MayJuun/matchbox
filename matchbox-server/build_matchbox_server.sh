#!/bin/bash

location="us-central1"
repository="cuestionario-sandbox"
projectId="mayjuun-questions-and-recipes"
projectName="matchbox"
appDir="."

#  Because I always forget this
gcloud config set project $projectId
# only needed the first time
# gcloud auth login


# # Build the docker container
docker build -t $projectName .

registryLocation="$location-docker.pkg.dev/$projectId/$repository/$projectName"

# tag the docker container
docker tag $projectName $registryLocation

# push the tagged image into the artifact registry
docker push $registryLocation

# return back to root directory
cd ..

# deploy on google cloud
gcloud run deploy $projectName --image $registryLocation
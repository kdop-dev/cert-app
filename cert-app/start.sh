#!/bin/bash
docker build -t kdop/cert-app:0.0.5 .
#docker push kdop/cert-app:0.0.5
docker run --rm -p 5000:5000 --name=cert-app kdop/cert-app:0.0.5
#!/bin/bash
USERNAME=yriahi
IMAGE=apache-alpine

docker build -t $USERNAME/$IMAGE:latest .

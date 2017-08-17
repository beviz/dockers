#!/bin/bash
set -x

docker build -t beviz/passenger $@ .


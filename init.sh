#!/bin/bash

vagrant box add --name ubuntu16 ubuntu16.box

#Clone repositories
# clone proto
if [ ! -e "trenchdefense-proto" ]; then
  git clone git@github.com:luandevinition/trenchdefense-proto.git
fi

# clone backend
if [ ! -e "trenchdefense-back" ]; then
  git clone git@github.com:luandevinition/trenchdefense-back.git
fi

# clone frontend
if [ ! -e "trenchdefense-front" ]; then
  git clone git@github.com:luandevinition/trenchdefense-front.git
fi
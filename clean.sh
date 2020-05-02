#!/bin/bash
read -p "Delete Jenkins, Postgress, and SonarQube data? " -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

rm -rf jenkins
rm -rf postgres
rm -rf sonarqube

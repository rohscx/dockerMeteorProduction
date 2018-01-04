#!/bin/bash -e
# =====================================================================
# Build script running NodeJS & mongoDB in Docker environment
#
# Source:
# Web:
#
# =====================================================================


# General enviromental varables
START_DELAY=40
NODE_HOME=/home/node/
NODE_PROJECT_NAME=dockerMeteorProduction
NODE_PROJECT_HOME=~/
NODE_PROJECT_APP_BOUNDLE="meteor-app.tar.gz"
NODE_PROJECT_APP_BOUNDLE_SERVER_DIR=bundle/programs/server
NODE_PROJECT_APP_BOUNDLE_DIR=~/nodeProjects/bundle
MONGO_URL=mongodb://localhost:27017/myapp
ROOT_URL=http://my-app.com
METEOR_SETTINGS="$(cat settings.json)"
PORT=3000
NODE_ENV=production

# Export enviromental variables for the applicaitons use
export MONGO_URL
export ROOT_URL
export METEOR_SETTINGS
export PORT
export NODE_ENV

# Error codes
E_ILLEGAL_ARGS=126

# Help function used in error messages and -h option
usage() {
  echo ""
  echo "Docker entry script for Meteor service container"
  echo ""
  echo "-f: Start Node in foreground with existing configuration."
  echo "-h: Show this help."
  echo "-s: Initialize environment like -i and start Meteor in foreground." !!!!!
  echo ""
}
# Initialize Nodejs environment
initConfig() {
  if [ ! "$(ls --ignore meteor-app.tar.gz --ignore package-lock.json --ignore settings.json -A)"  ]; then
    tar -xvf ${NODE_PROJECT_APP_BOUNDLE}
    cd ${NODE_PROJECT_APP_BOUNDLE_SERVER_DIR}
    npm install
    cd ${NODE_PROJECT_APP_BOUNDLE_DIR}
  else
    echo "Node configuration already initialized........."
    cd ${NODE_PROJECT_APP_BOUNDLE_DIR}
  fi
}

# Start MongoDB and redirect standard in and out to log file
startMongoDB() {
  mongod &
}

# Start Meteor Project and redirect standard in and out to log file
startMeteorProject() {
  sleep ${START_DELAY}
  node main.js
}

# Evaluate arguments for build script.
if [[ "${#}" == 0 ]]; then
  usage
  exit ${E_ILLEGAL_ARGS}
fi

# Evaluate arguments for build script.
while getopts fhis flag; do
  case ${flag} in
    f)
      startMeteorProject
      exit
      ;;
    h)
      usage
      exit
      ;;
    s)
      startMongoDB
      initConfig
      startMeteorProject
      exit
      ;;
    *)
      usage
      exit ${E_ILLEGAL_ARGS}
      ;;
  esac
done

# Strip of all remaining arguments
shift $((OPTIND - 1));

# Check if there are remaining arguments
if [[ "${#}" > 0 ]]; then
  echo "Error: To many arguments: ${*}."
  usage
  exit ${E_ILLEGAL_ARGS}
fi

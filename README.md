# dockerMeteorProduction
A production container for Meteor applications

Build the bundle
meteor build .. --architecture os.linux.x86_64
<<<<<<< HEAD
docker cp <CONTAINER ID>:<APP PATH>/meteor-app.tar.gz .
docker cp <CONTAINER ID>:<APP PATH>/settigs.json .
settings.json file should not contain white spaces '{"blah":"bleep"}' NOT '{"blah": "bleep"}'
doker build -t meteor-production .
=======

Export the bundle
<CONTAINER ID>:/home/meteor/meteor-app.tar.gz ../dockerProjects/dockerMeteorProduction/

About the Meteor settings file
The settings.json file should not contain white spaces '{"blah":"bleep"}' NOT '{"blah": "bleep"}'
>>>>>>> origin/master

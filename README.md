# dockerMeteorProduction
A production container for Meteor applications

meteor build .. --architecture os.linux.x86_64
docker cp <CONTAINER ID>:<APP PATH>/meteor-app.tar.gz .
docker cp <CONTAINER ID>:<APP PATH>/settigs.json .
settings.json file should not contain white spaces '{"blah":"bleep"}' NOT '{"blah": "bleep"}'
doker build -t meteor-production .

# dockerMeteorProduction
A production container for Meteor bundles

meteor build .. --architecture os.linux.x86_64
<CONTAINER ID>:/home/meteor/meteor-app.tar.gz ../dockerProjects/dockerMeteorProduction/
settings.json file should not contain white spaces '{"blah":"bleep"}' NOT '{"blah": "bleep"}'

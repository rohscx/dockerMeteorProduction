# dockerMeteorProduction
A production container for Meteor bundles

Build the bundle
meteor build .. --architecture os.linux.x86_64

Export the bundle
<CONTAINER ID>:/home/meteor/meteor-app.tar.gz ../dockerProjects/dockerMeteorProduction/

About the Meteor settings file
The settings.json file should not contain white spaces '{"blah":"bleep"}' NOT '{"blah": "bleep"}'

# dockerMeteorProduction
A production container for Meteor applications



meteor npm install --production

# Build source code boundle
meteor build .. --architecture os.linux.x86_64

# Extract source code boundle from container to production directory
docker cp {CONTAINER ID}:<APP PATH>/meteor-app.tar.gz .

# Extract settings.json file from container to production directory
docker cp {CONTAINER ID}:<APP PATH>/settigs.json .
  
# Build the production container
docker build -t meteor-production .

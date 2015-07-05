# Base image for meteor.
# FROM richburdon/meteor 
FROM jadsonlourenco/docker-meteor-base

# Build meteor app bundle (i.e., NodeJS app); then remove the source.
RUN mkdir /home/app
COPY app/ /home/src/demo
WORKDIR /home/src/demo
RUN meteor build .
RUN ls -las
RUN tar -xzf demo.tar.gz -C /home/app --strip-components 1
RUN rm -r /home/src/demo

# Install NPM modules.
WORKDIR /home/app/programs/server
RUN npm install

# Open container port.
EXPOSE 3000

# User "app" to run as non-root.
USER app

# Run the app.
WORKDIR /home/app
CMD ["node", "main.js"]

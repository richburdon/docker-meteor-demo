# Base image for meteor.
FROM richburdon/meteor 

# Build meteor app bundle (i.e., NodeJS app); then remove the source.
COPY app/ /home/app/src/
WORKDIR /home/app/src/
RUN meteor build .
RUN tar -xzf meteor.tar.gz -C ../ --strip-components 1
RUN rm -r /home/app/src/

# Open container port.
EXPOSE 3000

# User "app" to run as non-root.
USER app

# Run the app.
WORKDIR /home/app
CMD ["node", "main.js"]

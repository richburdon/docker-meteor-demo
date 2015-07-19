FROM ubuntu:trusty

# Install meteor.
RUN apt-get update && apt-get install -y curl wget unzip
RUN curl -sL https://deb.nodesource.com/setup | bash -
RUN apt-get install -y nodejs
RUN curl https://install.meteor.com/ | sh

# Install app.
RUN mkdir /home/app
COPY app/ /home/src/demo
WORKDIR /home/src/demo
RUN meteor build . --architecture os.linux.x86_64
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

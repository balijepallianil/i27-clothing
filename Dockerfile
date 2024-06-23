# Dockerfile for react application
# docker build -t node:v1 .


# reference : https://github.com/devopswithcloud/weather-app/blob/master/Dockerfile

FROM node:14
ARG SRC_DIR=/opt/i27
RUN mkdir $SRC_DIR
WORKDIR $SRC_DIR
COPY . $SRC_DIR
RUN npm install 
EXPOSE 3000
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
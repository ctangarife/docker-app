FROM node:10.16.3-alpine

LABEL maintainer="Freelanders <freelandersco@gmail.com>" \
      org.label-schema.vendor="Brief-strapi" \
      org.label-schema.name="Brief CMS" \
      org.label-schema.description="Strapi containerized" \
      org.label-schema.url="https://strapi.io" \
      org.label-schema.vcs-url="https://github.com/strapi/strapi-docker" \
      org.label-schema.version="latest" \
      org.label-schema.schema-version="1.0"

WORKDIR /usr/src/api

RUN echo "unsafe-perm = true" >> ~/.npmrc


RUN echo "$PWD"

COPY strapi.sh /usr/src/api
RUN chmod +x /usr/src/api/strapi.sh

EXPOSE 1337

COPY healthcheck.js /usr/src/api

#RUN npm install -g strapi@beta

HEALTHCHECK --interval=15s --timeout=5s --start-period=30s \
      CMD node /usr/src/api/healthcheck.js

CMD ["./strapi.sh"]

FROM node:4.2

RUN apt-get update

RUN apt-get -y install sispmctl

RUN groupadd -g 1000 app && useradd -u 1000 -g app -m -s /bin/bash app && mkdir /usr/src/app && chown app /usr/src/app
RUN chmod u+s /usr/bin/sispmctl

USER app
WORKDIR /usr/src/app

CMD ["npm", "start"]
EXPOSE 2638

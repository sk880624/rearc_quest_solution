=~=~=~=~=~=~=~=~=~=~=~= PuTTY log 2022.05.15 21:24:39 =~=~=~=~=~=~=~=~=~=~=~=
cat Dockerfile 
FROM node:12
WORKDIR /usr/src/app
COPY package*.json ./

RUN npm install
ENV SECRET_WORD ReArc_Quest
COPY . .
EXPOSE 8080
CMD [ "node", "index.js" ]
[root@ip-172-31-15-18 terraform_rearc_project]# 
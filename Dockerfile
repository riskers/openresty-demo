FROM node:lts-alpine as builder

WORKDIR /app

ARG profile
ENV profile=$profile

# copy file
COPY . /app
RUN npm i --sass_binary_site=https://npm.taobao.org/mirrors/node-sass/

# build 前端项目
RUN npm run build:${profile}

# FROM nginx:1.18.0
FROM openresty/openresty:centos

# 安装 lua 依赖模块: template
RUN luarocks install lua-resty-template

# 把编译后的结果放在 /fe 文件夹下
COPY --from=builder /app/dist /fe

COPY lua /lua

COPY view.lua /view.lua

COPY nginx.${profile}.conf /usr/local/openresty/nginx/conf/nginx.conf

EXPOSE 20112
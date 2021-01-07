# OpenResty

OpenResty + Dockerfile 部署前端项目

项目结构：

```bash
|-lua # lua 脚本
   |-req.lua
   |-http.lua 
   |-http_headers.lua
|-Dockerfile
|-view.lua # Lua 脚本脚本
|-src # 前端代码
```

## Docker

###  build image

```bash
docker build -t riskers/opde --build-args profile=staging .
```

### run image

```bash
docker run -d --name opde -p 20112:20112 riskers/opde
```

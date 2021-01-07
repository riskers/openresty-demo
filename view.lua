-- template 依赖
local template = require "resty.template"
local req = require "lua.req"
local http = require "lua.http"

-- 获取 cookie
ngx.ctx.cookies = req.get_cookie_from_headers(ngx.req.get_headers())

local httpc = http.new()
local res, err = httpc:request_uri(
  "http://st.mione.mi.srv",
  {
    path = "/api/server/info",
    method = "GET",
    headers = {
      ["Cookie"] = ngx.ctx.cookies
    }
  }
)

local data = nil

if (res.status ~= 200)
then
  data = "{}"
else
  data = res.body
end

-- 渲染模板
template.render("index.html", {
  info = data
})

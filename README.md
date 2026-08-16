# 我的个人主页

手写 HTML/CSS/JS 的个人网站，托管在 GitHub Pages（免费，无需服务器）。

## 目录结构

| 文件 | 作用 |
|---|---|
| `index.html` | 主页：名字、介绍、作品、联系都在这改 |
| `404.html` | 访问不存在的页面时展示 |
| `css/style.css` | 全部样式：配色、字体、间距 |
| `js/main.js` | 交互：滚动显现、年份自动更新 |

## 改哪里（搜索「你的」就能找到所有占位符）

- 名字 / 一句话介绍 → `index.html` 首屏
- 邮箱 → `index.html` 底部 `contact-mail`
- 社交链接 → `index.html` 底部 `footer-links`
- 配色 → `css/style.css` 顶部的 `:root`（改一处，全局生效）
- 作品卡片 → 复制 / 删除 `index.html` 里的 `<article class="work-card">`

## 发布到 GitHub Pages（命令行三步）

```bash
# 1. 登录 GitHub（仅第一次需要，浏览器授权一次）
gh auth login

# 2. 在 GitHub 网页新建一个「公开」仓库，仓库名必须是：
#    <你的用户名>.github.io
#    例如：zhangsan.github.io

# 3. 在项目目录里推上去（把 xxx 换成你的用户名）
git init -b main
git add .
git commit -m "我的个人主页"
git remote add origin https://github.com/xxx/xxx.github.io.git
git push -u origin main
```

等 1~2 分钟，打开 `https://<你的用户名>.github.io` 就能看到。

> 关键点：仓库名必须是 `<用户名>.github.io` 这种格式，GitHub 才会把它当作个人主页自动部署。

## 不想用命令行？网页版三步

1. GitHub 网页右上角 **+ → New repository**，名字填 `<你的用户名>.github.io`，选 **Public**
2. **Add file → Upload files**，把 `index.html`、`404.html`、`css`、`js` 全部拖进去，Commit
3. 仓库 **Settings → Pages → Source 选 Deploy from a branch → main / (root) → Save**

## 自定义域名（可选，以后想加再加）

1. 仓库根目录放一个 `CNAME` 文件，内容写你的域名，如 `www.example.com`
2. 到域名服务商加一条 CNAME 记录：`www → <你的用户名>.github.io`
3. 仓库 **Settings → Pages → Custom domain** 填域名并保存，GitHub 自动签发 HTTPS

## 部署到国内服务器（阿里云轻量，国内直连方案）

网站已可跑在 GitHub Pages；若要让国内访客物理直连（更快更稳），把站点搬到阿里云轻量服务器：

1. 买阿里云轻量服务器（选 **Ubuntu 24.04 LTS**），把 `deploy/` 目录传到服务器后执行：
   ```bash
   bash setup-server.sh 你的域名
   ```
2. 把 `my-site` 内容同步到服务器 `/var/www/my-site`
3. 配置 GitHub Actions Secrets（仓库 Settings → Secrets and variables → Actions）：
   - `SSH_PRIVATE_KEY`：能登录服务器的 SSH 私钥
   - `SERVER_IP`：服务器公网 IP
4. 以后每次 `git push` 到 main，网站自动更新（见 `.github/workflows/deploy.yml`）
5. ICP 备案通过后：域名解析到服务器 IP，再配 HTTPS（阿里云免费证书或 certbot）

## 小贴士

- 改完推送后，等 1 分钟左右生效；可以在仓库 **Actions** 页看部署进度
- 图片放到 `images/` 目录，HTML 里用相对路径引用（`images/xx.png`），换域名也不怕
- 想加博客？GitHub Pages 原生支持 Jekyll，也可以接 Hugo / Astro / Vite，构建后把产物推到 Pages 即可

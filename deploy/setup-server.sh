#!/usr/bin/env bash
# ============================================================
# 阿里云轻量服务器一键初始化脚本
# 用法: bash setup-server.sh 你的域名
# 要求: 全新 Ubuntu 22.04 / 24.04 LTS，root 身份执行
# 效果: 安装 Nginx，建好站点目录 /var/www/my-site
# ============================================================
set -euo pipefail

DOMAIN="${1:?用法: bash setup-server.sh 你的域名}"

export DEBIAN_FRONTEND=noninteractive

echo "==> 更新系统并安装 Nginx / rsync"
apt-get update -y
apt-get install -y nginx rsync

echo "==> 创建站点目录"
mkdir -p /var/www/my-site
chown -R www-data:www-data /var/www/my-site

echo "==> 生成 Nginx 站点配置（域名: $DOMAIN）"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
sed "s/YOUR-DOMAIN\.com/$DOMAIN/g" "$SCRIPT_DIR/nginx-site.conf" \
  > /etc/nginx/sites-available/my-site
ln -sf /etc/nginx/sites-available/my-site /etc/nginx/sites-enabled/my-site
rm -f /etc/nginx/sites-enabled/default

echo "==> 校验并启动 Nginx"
nginx -t
systemctl enable nginx
systemctl restart nginx

echo ""
echo "=============================================="
echo " ✅ Nginx 已就绪"
echo "    站点目录: /var/www/my-site"
echo "    域名:     $DOMAIN"
echo "    下一步: 把网站文件同步到 /var/www/my-site"
echo "    备案通过后再配 HTTPS（certbot 或云厂商免费证书）"
echo "=============================================="

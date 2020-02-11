# Chú ý
## 1. Thay đổi root
Khi thay đổi 1 root mới , không phải mặc đinh (/usr/share/nginx/html)

Cần chú ý config SELinux
- C1: semanage permissive -a httpd_t
- C2: chcon -Rt httpd_sys_content_t /srv/www/test.com
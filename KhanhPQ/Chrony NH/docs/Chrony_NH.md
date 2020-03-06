# Chrony NH
```
timedatectl set-timezone Asia/Ho_Chi_Minh
timedatectl 
```

```
firewall-cmd --add-service=ntp --permanent 
firewall-cmd --reload 
```

```
sudo setenforce 0
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
sed -i 's/SELINUX=permissive/SELINUX=disabled/g' /etc/sysconfig/selinux
```

Chrony đã cài trên cụm lab rồi 

```
vi /etc/chrony.conf
```

Sửa như hình 
<img src="..\imgs\Screenshot_1.png">

Phần bôi đỏ -> điển IP NTP server (Xem trong bảng IP)

```
systemctl restart chronyd.service
```
check lại
```
chronyc sources -v
```
<img src="..\imgs\Screenshot_2.png">

===========================================
<img src="..\imgs\Screenshot_3.png">
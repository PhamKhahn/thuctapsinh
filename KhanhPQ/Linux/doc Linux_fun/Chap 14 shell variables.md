# Chap 14 : shell variables

Quản lý các biến môi trường trong shell. Các biến này thường cần thiết cho các chương trình.

# 14.1 $

Shell tìm kiếm biến môi trường bằng cách cho tên biến theo sau dấu **$**

<img src="..\imgs\Screenshot_22.png">

# 14.2 tạo biến

```
[root@ansible ~]# MyVar=5555
[root@ansible ~]# echo $MyVar
5555
```
# 14.3 quotes
```
[root@ansible ~]# echo $MyVar
5555
[root@ansible ~]# echo "$MyVar"
5555
[root@ansible ~]# echo '$MyVar'
$MyVar
```

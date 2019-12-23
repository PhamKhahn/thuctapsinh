# Linux Command1
- man
- whatis
- whereis
## 1. Các *man* page
- Còn gọi là manual pages (Các trang hướng dẫn)
- Ấn **q** để thoát khỏi manpage
### 1.1. man $command
- Gõ **man** theo sao là 1 command mà ta muốn biết chi tiết về nó ( nó để làm gì, các option ra làm sao)
```
#man ls
```
![Imgur](https://i.imgur.com/eWqGZab.png)

### 1.2. man $configfile
Hầu hết các fileconfig đều có hướng dẫn, ta có thể xem nó thông qua lệnh man
```
#man rsyslog.conf
```
![Imgur](https://i.imgur.com/7GCpy53.png)

### 1.3. man $daemon
Điều này cũng tương tự đối với các daemons (các trình chạy background) trên hệ thống
```
#man rsyslogd
```
![Imgur](https://i.imgur.com/nQEFdWm.png)

### 1.4. man -k (apropos)
man -k (apropos) sẽ show ra danh sách các man page có chứa chuỗi tương ứng
```
#man -k more

#man -k rsyslog
```
![Imgur](https://i.imgur.com/PxnrVph.png)

### 1.5. whatis
Xem phần mô tả của 1 man page

```
#whatis route

#whatis ls
```
![Imgur](https://i.imgur.com/BCFsVcq.png)

### 1.6. whereis
Tìm vị trí lưu man page
```
#whereis -m ls
```
Option

    -m: chỉ tìm manual (man page)

![Imgur](https://i.imgur.com/DbjhLxb.png)
Tập tin này có thể được đọc trực tiếp bởi man
```
#man /usr/share/man/man1/ls.1.gz
```

### 1.7. man section
![Imgur](https://i.imgur.com/eWqGZab.png)
![Imgur](https://i.imgur.com/k0KZgVt.png)
Các con số 1 -> 9 là các section number. Gõ :
```
#man man 
```

![Imgur](https://i.imgur.com/aLvmTex.png)

### 1.8. man $section $file
Khi 1 file có nhiều section -> sử dụng section đi kèm để mở chính xác page

```
#man 1 ls
```
### 1.9. man man
Chính bản thân lệnh man cũng các manual page của nó
```
#man man
```
#### 1.10. mandb

Nếu ta tin rằng 1 man page tồn tại mà lại không access được vào nó thì sử dụng
```
#mandb
```

# Linux Command2
- pwd
- cd
- ls
- mkdir
- rmdir

### 1.1. pwd
Chỉ ra vị trí thư mục ( đường dẫn tuyệt đối) hiện tại mà ta đang đứng (làm việc)
```
#pwd
```
![Imgur](https://i.imgur.com/Y38CNEz.png)

### 1.2. cd 
Thay đổi thư mục ta đang đứng

![Imgur](https://i.imgur.com/NUukyd8.png)

### 1.2.1 cd ~
cd có 1 cách nhanh chóng quay lại home dir .

Gõ 
```
#cd
```
![Imgur](https://i.imgur.com/fE6Lt8n.png)
hoặc 
```
#cd ~
```
Có tác dụng tương tự

![Imgur](https://i.imgur.com/LEE4st7.png)

### 1.2.2 cd ..
Di chuyển về thư mục cha

![Imgur](https://i.imgur.com/UaQqPmD.png)

### 1.2.3 cd -
Quay trở lại thư mục ta vừa rời đi trước đó
![Imgur](https://i.imgur.com/yU7xUY2.png)
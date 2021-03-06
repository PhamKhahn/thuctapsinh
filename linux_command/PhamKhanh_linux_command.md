# Linux Command1 :  man pages 
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
=============================================================
# Linux Command2 :  working with directories
Làm việc với các directory
- pwd
- cd
- ls
- mkdir
- rmdir

dir: directory
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


### 1.3. ls
- Liệt kê các content của thư mục
- Các option đi kèm của ls:
```
-a : Hiển thị tất cả các file,dir kể cả các file và dir ẩn 
-l : Hiện thị chi tiết thuộc tính,các quyền, sở hữu, độ lớn của file,dir
-lh : Hiển thị chi tiết; thông số độ lớn sẽ hiện thị ở dạng dễ đọc hơn 
```
![Imgur](https://i.imgur.com/DA6oaFz.png)

### 1.4. mkdir
Tạo các dir 
```
#mkdir option <tên dir/ đường dẫn đến nơi tạo dir kèm tên dir>
```
- option thường dùng:
```
-p : Tạo cả dir cha trong đường dẫn nếu dir đó chưa tồn tại
```

![Imgur](https://i.imgur.com/txjtZJd.png)
![Imgur](https://i.imgur.com/LDOC7XP.png)

### 1.5. rmdir
Xóa 1 dir nếu nó trống (empty)
```
#rmdir option path
```
option:
```
-p : Xóa kiểu đệ quy (Xóa dir cuối trong path nếu nó trống;rồi đến dir cha của nó;cứ thể chạy ngược lại cho đến khi dir được chọn không trống)
```
![Imgur](https://i.imgur.com/Y7lrJNo.png)

===============================
# Linux Command 3 : working with files
Làm việc với file
 - file
 - touch
 - rm
 - cp
 - mv
 - rename

 ### 1.1. file
- Xác định loại của file
- Linux không sử dụng extension mở rộng đuôi file (ví dụ: file1.pdf nhưng bản chất lại là file text -> đuôi không phản ánh loại file ) 

![Imgur](https://i.imgur.com/4PU6d6t.png)

### 1.2. touch
- Tạo 1 file trống mới
- Thêm option "-t" để set time cho file . Nếu không sẽ lấy theo giờ trên hệ thống

![Imgur](https://i.imgur.com/LdWSwxV.png)


### 1.3. rm
- 2 option:
```
-i : Hỏi trước khi xóa file. (thực ra nếu không thêm thì vẫn sẽ hỏi- trên CentOS7)
-rf : Xóa mọi thứ miễn là ta có quyền ( cần thận khi sử dụng rm -rf khi đang là root)
```
![Imgur](https://i.imgur.com/RNfxn8q.png)


### 1.4. cp
Copy file
- Các option:
```
-r : copy 1 folder tới 1 folder khác
-i : Hỏi trước khi ghi đè (Trên CentOs7 không thêm -i, vẫn hỏi)
```

![Imgur](https://i.imgur.com/Jh3vuyE.png)
![Imgur](https://i.imgur.com/q7k4Xau.png)

### 1.5. mv
Thay đổi tên file/dir hoặc di chuyển file/dir tới 1 dir khác
- Option
```
-i : Hỏi trước khi ghi đè (Tương tự những phần trên, không có -> vẫn hỏi)
```
![Imgur](https://i.imgur.com/ywQn7gT.png)

### 1.6. rename
Đổi tên file
- Nếu đổi số lượng ít -> dùng lệnh **mv**
- Nếu số lượng nhiều dùng **rename**
 
 Trên CentOs  (Trên Ubuntu sẽ khác)
 ```
#rename [options] expression replacement file...
 ```
 Ví dụ:

 ```
rename .txt .pdf *.txt
 ```
 --> đổi tất cả các file có đuôi .txt thành đuôi .pdf

 ![Imgur](https://i.imgur.com/aHysvlm.png)


===============================================================

# Linux Command 4 :  working with file contents
Làm việc với nội dung file
- head
- tail
- cat
- tac
- more
- less
- strings

### 1.1. head
- Hiển thị 10 dòng đầu tiên của file
- Các option
```
-n : Hiển thị n dòng đầu tiên
-cn      : Hiển thị n byte đầu tiên
```
![Imgur](https://i.imgur.com/LosoE5I.png)

### 1.2. tail
- Hiển thị 10 dòng cuối cùng của file
- Các option:
```
-n : Hiển thị n dòng cuối cùng
-f : Hiển thị đồng thời theo dõi file -> file được update -> hiển thị thêm
```

![Imgur](https://i.imgur.com/MI6LPHz.png)

### 1.3. cat
(copy standard input đưa ra standard output)

Có thể cat 1 lúc nhiều file

![Imgur](https://i.imgur.com/V0PBSHm.png)

- 1 số trường hợp sử dụng khác của cat
```
#cat file1 file2 ... > text.txt     : Đưa nội dùng file1,file2,.. vào file text.txt (Nếu chưa có -> tạo; Nếu file đã có content -> Xóa content, ghi mới)
```
![Imgur](https://i.imgur.com/4TDLoUp.png)
```
#cat > newfile.txt      : Tạo 1 file mới và cho phép nhập content ngay bên dưới lệnh ( Ctrl D để send EOF đến tiến trình đang chạy và kết thúc cat )
```
![Imgur](https://i.imgur.com/JFkOIJx.png)
```
#cat > newfile << stop  : Tạo 1 file mới và cho phép nhập content ngay bên dưới lệnh. Khi duy nhất từ "stop" trên 1 dòng mới và Enter -> sẽ kết thúc nhập

```
![Imgur](https://i.imgur.com/HV091aE.png)

```
#cat file1 > text.txt : tương tự trường hợp đầu tiên (copy nội dung file1 nếu tồn tại đưa vào text.txt)
```

### 1.4.tac
Tương tự lệnh cat nhưng đọc ngược từ dưới lên

![Imgur](https://i.imgur.com/MU7bf61.png)

### 1.5. more và less
Hiển thị nội dung các file lớn (mức hiển thị vượt quá 1 màn hình)

+) more : dùng SPACE để chuyển tới trang tiếp, hoặc Enter để xem từ từ các dòng tiếp theo
+) less : cho phép sử dụng lăn chuột lên xuống

Cả 2 đều ấn **q** để thoát

### 1.6. strings
- Lệnh **strings** sẽ in/hiển thị tất cả các chuỗi chữ cái,ký tự

    Những line chỉ có số hay rỗng thì sẽ không hiển thị

    Những line chỉ cần có xuất hiện chữ cái,kỹ tự sẽ hiển thị cả dòng (cả số, khoảng trắng)

    ![Imgur](https://i.imgur.com/IY7YFDJ.png)

- Ngoài ra strings còn có thể đọc được các chuỗi ascii trong các tệp nhị phân (binary file)

    ![Imgur](https://i.imgur.com/5em2UbK.png)

===================================================================

# Linux Command 5: the Linux file tree
- Tất cả mọi thứ trong Unix đều là file

- Cấu trúc thư mục bắt đầu từ **root directory** đại diện bằng dấu **/**

## 1. /bin
Chứa các tệp nhị phân (các lệnh thường dùng)

## 2. /sbin
Chứa các tệp nhị phân cấu hình hệ điều hành. Yêu cầu quyền root để thực hiện các tác vụ nhất định
## 3. /lib
Các tệp nhị phân ở /bin và /sbin
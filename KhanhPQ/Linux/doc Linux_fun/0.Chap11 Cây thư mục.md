# Linux Fun

# Chap 11: the Linux file tree
## 11.1 binary directories

### 11.1.1 /bin
- /bin : chứa các binary được sử dụng cho tất cả user. (cp,ls,... các bin mà khi ta gõ các lệnh sẽ gọi tới và thực thi chúng)

- /sbin : chứa binary có việc config OS. Nhiều system binary yêu cầu quyền root để chạy 

### 11.1.2. /lib
- /lib : các binary trong /bin và /sbin thường sử dụng các library được chia sẻ chung và được lưu trong /lib
- /lib/modules : Thông thường Linux kernel load các kernel module từ /lib/modules/$kernel-version/
- /lib32 và /lib64 : Các máy 64 bit có thể vẫn có các thư viện 32 bit để tương thích với các ứng dụng cũ
- /opt : Mục đích là lưu trữ các phần mềm tùy chọn. Trong nhiều trường hợp đó là các phần mềm ngoài repo

## 11.2 configuration directories
### 11.2.1 /boot
Chứa tất cả file cần có việc boot máy. Các file này không thay đổi thường xuyên.
Trên Linux có thể tìm thấy /boot/grub . Trong này chứa /boot/grub/grub.cfg cái sẽ chỉ định,khai báo boot menu được hiển thị khi kernel khởi động

### 11.2.1 /etc
Chứa toàn bộ tệp cấu hình của máy

- /etc/init.d/ : nhiều bản Unix/Linux có dir /etc/init.d, nó chứa các scrpit để start hoặc stop các daemon.

- /etc/X11/  : màn hình đồ họa. Config file cho màn hình đồ họa này ở /etc/X11/xorg.conf.

- /etc/skel/ : thường chứa các file ẩn như .bashrc . Và được copy vào thư mục home của user mới được tạo

- /etc/sysconfig/ : Chứa nhiều tệp cấu hình Red Hat Enterprise Linux

## 11.3 data directories
### 11.3.1 /home
User có thể lưu các dữ liệu cá nhân, các project ở đây. 

### 11.3.2 /root
Trên nhiều hệ thống, /root là location mặc định cho các dữ liệu cá nhân và thông tin của **root user** . Nếu không tồn tại theo mặc định thì sau đó admin sẽ tạo nó.
### 11.3.3 /srv
Sử dụng /srv cho dữ liệu được cung cấp bởi hệ thống

 FHS cho phép việc lưu trữu các dữ liệu cvs,rsync,fto, www ở đây.

 ### 11.3.4 /media
 Đóng vai trò là mount point cho các thiết bị đa phương tiện (removable media devices) như CD-ROM, digital camera,, USB

### 11.3.5 /mnt
Nên để trống, sử dụng cho các mount point tạm thời
### 11.3.6 /tmp
Không bao giờ sử dụng / tmp để lưu trữ dữ liệu quan trọng.

Các ứng dụng và user nên dùng /tmp để lưu các dữ liệu tạm thời. Nó sử dụng disk space hoặc RAM 

--> Có thể gây mất dữ liệu khi máy khởi động lại.

## 11.4 memory directories
### 11.4.1  /dev
Các file trong này không nằm trên hard disk. Chúng xuất hiện khi kernel nhận phần cứng (tượng trưng cho các phần cứng đang được chấp nhận)

Ngoài ra cũng có 1 số file đặc biệt
- /dev/tty and /dev/pts

    - /dev/tty1 đại diện cho terminal hoặc console được attach vào hệ thống
    - Khi gõ command trên terminal thì terminal lúc này được đại diện lại bằng /dev/pts/1 (có thể là số khác)

- /dev/null : Được coi như 1 "black hole" . Đưa mọi thứ về đây và chúng sẽ bị loại bỏ. Ví dụ output của 1 lệnh nhưng ta không muốn nó được show lên màn hình, lúc này ta redirect nó về /dev/null.

### 11.4.2  /proc
Trông thì có vẻ nó chứa các tệp thông thường. Tuy nhiên chúng lại không chiếm disk space. 

Thực chất đây là những gì mà kernel quản lý và đây thực chất chỉ là kernel view chúng lên 1 cách trực quan 

### 11.5 /sys
Chứa thông tin thông tin kernel về phần cứng

### 11.6  /usr
Hệ thống phân cấp / usr phải chứa dữ liệu có thể chia sẻ, chỉ đọc.

## 11.7 /var 
Lưu các tệp không đoán trước được về kích thước như log, cache.,...

-  /var/log/messages : Tệp đầu tiên cần check khi troubleshooting trên RedHat. Nó chứ tất cả thông tin về những gì đã xảy ra với hệ thống

- /var/cache : chứa cache data cho 1 vài ứng dụng
- /var/spool  : chứa các thư mục  cho mail, cron
- /var/lib : Chứa thông tin trạng thái ứng dụng

    Ví dụ : RedHat giữ các file liên quan đến rpm trong /var/lib/rpm
-  /var/run  : Chứa các Process ID (sẽ được thay bằng /run sau này)
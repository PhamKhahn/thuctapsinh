# Chap 12
- Commands và arguments

- Giao diện dòng lệnh / shell được sử dụng trên hẩu hết các Linux system là **bash**

## echo

Lặp lại input. mặc định thì đưa ra màn hình

<img src="..\imgs\Screenshot_1.png">

## 1. arguments
- Gõ shell -> quét command line -> cắt argument -> thưc hiện thay đổi theo argument đã nhập -> quét xong -> thực thi 

# 2. Loại bỏ khoảng trắng
Các argument cách nhau bởi 1/nhiều khoảng trắng. Các khoảng trắng này sẽ bị loại bỏ

- argument đầu tiên là command
- các argument còn lại được cung cấp cho command

<img src="..\imgs\Screenshot_2.png">

Lệnh echo tự động thêm 1 khoảng trắng vào giữa các argument nó nhận được

# 3. Dấu nháy đơn '  '
Ngăn việc bỏ khoảng trắng bằng dấu nháy đơn -> coi nội dung bên trong ' ' là 1 argument.

<img src="..\imgs\Screenshot_3.png">

# 4. Dấu nháy kép "   "
 Tương tự nháy kép

 Khác nhau khi làm việc với biến
# 5. echo và các dấu nháy

**echo -e** cho phép bao gồm ký tự đặc biệt như \n hay \t ...

<img src="..\imgs\Screenshot_5.png">

<img src="..\imgs\Screenshot_6.png">

# 6. commands
2 loại
- lệnh ngoài (tệp binary trong /bin hoặc /sbin)
- lệnh dựng sẵn (builtin commands )

## 6.1 type
Lệnh **type** để xem loại command.
 Cũng có thể dùng để xem command có phải alias hay không
<img src="..\imgs\Screenshot_7.png">

## 6.2 which
Tìm binary trong biến môi trường **$PATH** 

<img src="..\imgs\Screenshot_8.png">

# 7. aliases
## 7.1 Tạo 1 alias
Shell cho phép tạo các **alias** (giúp dễ dàng nhớ tên của 1 lệnh hoặc dễ dàng cung cấp đối số)

Rút ngắn 1 lệnh + đối số dài -> thành 1 lệnh ngắn hơn

<img src="..\imgs\Screenshot_9.png">

## 7.2 Viết tắt lệnh
Như đề cập ở trên. --> dùng alias để viết tắt những lệnh dài

<img src="..\imgs\Screenshot_10.png">

## 7.3 default options
Việc cung cấp 1 đối số default cho 1 lệnh đôi khi là cần thiết .

Ví dụ lệnh rm thêm đối số i để hỏi trước khi xóa. Tránh việc xóa nhầm.

<img src="..\imgs\Screenshot_11.png">

alias 1 số lệnh sau khá có ích : 'rm
-i', 'mv -i', 'cp -i'

## 7.4 Xem các alias 
<img src="..\imgs\Screenshot_12.png">

## 7.5 unalias

<img src="..\imgs\Screenshot_13.png">



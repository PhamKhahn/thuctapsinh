# Chap13 Kiểm soát việc vận hành

# 1. ; (semicolon)

Giúp đặt hai hoặc nhiều hơn các command trên cùng 1 dòng

Thực hiện tuần tự. Xong lệnh trước rồi mới đến lệnh sau.

<img src="..\imgs\Screenshot_14.png">

# 2. &
Kết thúc lệnh bằng &, shell sẽ không đợi đến khi lệnh kết thức mà sẽ trở lại shell để thao tác tiếp luôn. Lệnh sẽ được thực thi ở background

Lệnh thực thi xong sẽ có thông báo
<img src="..\imgs\Screenshot_15.png">

# 3. $?

Lưu mã của lệnh vừa chạy (kiểu như kết quả lệnh)

- Lệnh thực thi bình thường -> code : 0
- Lệnh không thực thi được  -> code : != 0

<img src="..\imgs\Screenshot_16.png">

# 4. &&
Thay cho phép logic AND
Ví dụ :
```
 echo first && echo second
```

Lệnh thứ hai thực thi chỉ khi lệnh thứ nhất đã thực thi thành công

# 5. ||
Thay cho phép logic OR

Lệnh thứ hai thực thi chỉ khi lệnh thứ nhất thực thi không thành công

<img src="..\imgs\Screenshot_17.png">

# 6. Kết hợp && và ||

Có thể kêt hợp 2 biểu thức logic này để viết cấu trúc  **if-then-else** trên command line

<img src="..\imgs\Screenshot_18.png">

# 7. Dấu #

Tất cả những gì sau dấu # đều được shell bỏ qua

<img src="..\imgs\Screenshot_19.png">

# 8. Dấu \ (dùng với các ký tự đặc biệt)

Sử dụng để kiểm soát các ký tự, shell bỏ qua nó 

Đi kèm 1 số ký tự đặc biệt (\ ; # & " ' ? *) để shell có thể hiểu các ký tự đó theo 1 nghĩa khác

Ví dụ dấu # với ý nghĩa như trên. Nhưng khi ta muốn in ra dấu #

<img src="..\imgs\Screenshot_20.png">

## 8.1 Xuống dòng nhưng chưa kết thúc dòng .
Khi Enter xuống dòng thì shell coi như ta kết thúc 1 dòng . Nhưng nếu cuối dòng có \ thì mặc dù xuống dòng nhưng dòng đó chưa kết thúc . Những gì ở dòng tiếp theo, khi shell thực thi sẽ nối tiếp vào dòng cũ
<img src="..\imgs\Screenshot_21.png">



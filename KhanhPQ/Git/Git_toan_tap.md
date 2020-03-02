# GIT
## 1. commit

## 2. rẽ nhánh

2.1 Tạo nhánh mới

```
git branch newImage
```
newImage    : tên nhánh mới

2.2 Chuyển nhánh
```
git checkout <name>
```

VD: 
git checkout newImage
git commit

Chuyển nhánh mới rồi mới commit -> Thay đổi lưu sang nhánh mới

2.3 Tạo và chuyển nhánh cùng 1 lúc
```
git checkout -b <branch_name>
```

## 3. Gộp nhánh
```
git merge
```
2 nhánh, mỗi nhánh 1 commit riêng
![Imgur](https://i.imgur.com/ZShoVw4.png)

- Gộp bugFix vào master (Đang đứng trên master)

```
git merge bugFix
```
![Imgur](https://i.imgur.com/BjqQ2nc.png)

- Gộp master vào bugFix
```
git checkout bugFix; git merge master
```

![Imgur](https://i.imgur.com/wbxmgF0.png)

## 4. Rebase
Cách thứ 2 để kết hợp thành của của 2 nhánh là rebase. Rebase về căn bản là chọn một loạt các commit, "sao chép" chúng, và ném chúng sang chỗ khác.

lợi thế của rebase là có thể tạo ra cây lịch sử thẳng tuột. Ljch sử commit nhìn sẽ gọn gàng hơn nhiều.


Đang đứng tại nhánh bugFix

![Imgur](https://i.imgur.com/YlU7Aok.png)

```
git rebase master
```
bugFix sẽ thành con của master
![Imgur](https://i.imgur.com/CqRW9aL.png)

Chuyển qua nhánh master

![Imgur](https://i.imgur.com/Dtf6goy.png)
```
git rebase bugFix
```
![Imgur](https://i.imgur.com/P7ZRxMC.png)


## 5. Dịch chuyển trong Git


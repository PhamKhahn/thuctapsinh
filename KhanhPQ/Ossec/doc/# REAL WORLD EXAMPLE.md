# REAL WORLD EXAMPLE

# 1. Sửa đổi Severity Level của Rule
Tùy vào đặc điểm môi trường mà có thể chỉnh sửa level rule lên mức cao hơn mức mặc định.

Cách làm: Copy rule vào **local_rules.xml** và sửa level.

Lưu ý: Không sửa trực tiếp vào file rule ban đầu vì khi upgrade, Ossec sẽ overwrite lại các file này --> mất những gì mới sửa đổi.

**Copy** 
<img src="..\img\Screenshot_72.png">

**Paste vào local_rules.xml và sửa đổi**
<img src="..\img\Screenshot_73.png">


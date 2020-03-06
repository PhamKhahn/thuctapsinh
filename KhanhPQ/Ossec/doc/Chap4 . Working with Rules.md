# Chap4 . Working with Rules

Các decoder và các rule là sức mạnh của OSSEC HIDS

# 1.**DECODER**
-  các decoder nằm trong */var/ossec/etc/decoders.xml*
- Dùng để trích xuất dữ liệu từ các sự kiện thô --> Giúp Ossec tạo tương quan giữa các sự kiện đến từ các nguồn khác nhau.

# 2.**RULE**
- các rule lưu ở dir **rules/** trong thư mục cài đặt Ossec HIDS - thường là **/var/ossec/rules**
- 1 File rule là 1 file XML gốm nhiều rule nhỏ và được đặt tên tương ứng 

Ví dụ: 
- tất cả các rule về Apache HTTP server được lưu *apache_rules.xml* . 
- Rule về Nginx thì là *nginx_rules.xml*

    <img src="..\img\Screenshot_40.png">
    <img src="..\img\Screenshot_37.png">
    <img src="..\img\Screenshot_38.png">
    <img src="..\img\Screenshot_39.png">

- Với rule do người dùng tạo range ID từ 100000-119999 (tránh việc trùng lặp các ID rule sẵn có)

    Lưu ở *local_rules.xml* trong */var/ossec/rules/local_rules.xml*

    <img src="..\img\Screenshot_41.png">
    <img src="..\img\Screenshot_42.png">
    <img src="..\img\Screenshot_43.png">
    <img src="..\img\Screenshot_44.png">

- Qua trình upgrade sẽ khiến **tất cả các rule bị overwrite** , trừ *local_rules.xml* -> muốn điều chỉnh rule --> viết vào *local_rules.xml*

# 3. Quá trình phân tích của OSSEC HIDS
<img src="..\img\Screenshot_45.png">
- Ngay khi nhận event, Ossec sẽ decode và trích xuất thông tin.

- Các trường dùng để decode: 
    <img src="..\img\Screenshot_46.png">
    <img src="..\img\Screenshot_47.png">

- Sau khi dữ liệu này được trích xuất, rule-matching engine được gọi để xác minh xem có rule nào match không và có nên tạo cảnh báo hay không.


## 3.1 Predecoding Events
Trích xuất static information. Thường sử dụng với các log mess sử dụng Syslog, Apple System Log. Các thông tin được trích xuất:
- time
- date
- hostname
- program name
- log message

    <img src="..\img\Screenshot_48.png">
## 3.2 Decoding Events
Trích xuất non-static information -> Những thông tin sẽ sử dụng trong các rule.

Thường là :
- IP
- usernames
- data
- ...

    <img src="..\img\Screenshot_49.png">


Thường lưu tại */var/ossec/etc/decoder.xml* . 1 số cú pháp

<img src="..\img\Screenshot_50.png">
<img src="..\img\Screenshot_51.png">

prematch tuân theo cú pháp regexp đơn giản

Hiện tại trong decoder.xml viết nhiều bằng prematch_pcre2 -> tuân theo cú pháp pcre2. 

Tương tự với program_name và program_name_pcre2

Xem thêm : 
https://ossec-documentation.readthedocs.io/en/latest/manual/lids/decoders.html

<img src="..\img\Screenshot_52.png">


Mẫu log:
```
Sun Jun 4 22:08:39 2006 [pid 21611] [dcid] OK LOGIN: Client “192.168.1.1”
```
đoạn prematch
```
<prematch>^\w+ \w+\s+\d+ \S+ \d+ [pid \d+] </prematch>
<regex offset=“after_prematch”>^[(\w+)] OK LOGIN: Client “(\d+.\d+.\d+.\d+)”$</regex>

```
^ : bắt đầu dòng
\ w+ : 1 hoặc nhiều từ
\ s+ : 1 hoặc nhiều khoảng trắng
\ d+ : 1 hoặc nhiều số
\ S+ : 1 hoặc nhiều khoảng không trắng (!= trắng)

Chú ý dấu cách khi viết. --> Ví dụ : **\w+\s+\d+** ở ví dụ trên sẽ cho ta **Jun 4 22:08:39**

```
<decoder name=“vsftpd”>
 <prematch>^\w+ \w+\s+\d+ \S+ \d+ [pid \d+] </prematch>
 <regex offset=“after_prematch”>^[(\w+)] OK LOGIN: Client
“(\d+.\d+.\d+.\d+)”$</regex>
 <order>user, srcip</order>
</decoder>
```
Prematch sẽ tìm ngày giờ. Nó sẽ đọc “Sun Jun 4 22:08:39 2007”

Sau đó đến lượt  regex sẽ đọc " [pid 21611] [dcid] OK LOGIN: Client “192.168.1.1”" và lấy ra 2 field mới lọc được đặt chúng là user, srcip

`<parent>` : khi ta gọi 1 decoder khác trong 1 decoder. decoder cha được thự thi thì decoder mới được
```xml
<decoder name=“sshd”>
<program_name>^sshd</program_name>
</decoder>

<decoder name=“sshd-success”>
<parent>sshd</parent>
<prematch>^Accepted</prematch>
<regex offset=“after_prematch”>^ password for (\S+) from (\S+) port </regex>
<order>user, srcip</order>
</decoder>

<decoder name=“ssh-failed”>
<parent>sshd</parent>
<prematch>^Failed password </prematch>
<regex offset=“after_prematch”>^for invalid user \S+ from (\S+) </regex>
<order>srcip</order>
</decoder>

```

<img src="..\img\Screenshot_54.png">

# 4. Understanding Rules
*/var/ossec/rules/*

OSSEC HIDS sẽ đánh giá qua các rules để xem có nên tạo cảnh báo đối với event hay không.

2 loại rule:
- Đơn (atomic)
    ```
    - based trên single event , không thêm mỗi liên quan khác.

    Ví dụ : thấy 1 authentication failure thì tạo alert về sự kiện đó luôn
    ```
- Kép (composite)
    ```
    - based trên multiple events

    Ví dụ: Muốn tạo alert sau 10 authentication failures từ cùng 1 IP address --> Cần 1 rule kép
    ```
## 4.1 Atomic Rules
## 4.1.1 Viết Rule

Mỗi rule hay nhóm rule đều phải được khải báo trong 1 `<group></group>`. Thuộc tính `name`
```xml
<group name=“syslog,sshd,”>
</group>
```
Dấu phẩy **name=“syslog,sshd,”** là cần thiết nếu muốn thêm group vào trong rules.
<img src="..\img\Screenshot_55.png">


1 rule được define trong `<rule></rule>` . Phải có 2 thuộc tính:
- id

    duy nhất - là signature

    rule do user define có range từ 100,000 đến 119,999
- level

    Mức cảnh báo

```
<group name=“syslog,sshd,”>
  <rule id=“100120” level=“5”>
  </rule>
  <rule id=“100121” level=“6”>
  </rule>
</group>
```

Có thể thêm subgroup trong group cha, sử dụng `<group></group>` . Thêm mô tả qua tag `<description></description>`
```xml
<group name=“syslog,sshd,”>
  <rule id=“100120” level=“5”>
    <group>authentication_success</group>
    <description>SSHD testing authentication success</description>
  </rule>
  <rule id=“100121” level=“6”>
    <description>SSHD rule testing 2</description>
  </rule>
</group>
```

<img src="..\img\Screenshot_56.png">
<img src="..\img\Screenshot_57.png">
<img src="..\img\Screenshot_58.png">
<img src="..\img\Screenshot_59.png">

https://ossec-documentation.readthedocs.io/en/latest/legacy/docs/manual/notes/rule_groups.html

1 tag quan trọng khác là `<decoded_as></decoded_as>` : Rule sẽ chỉ được đánh giá khi decoder được chỉ định decoded được log

```xml
<rule id=“100123” level=“5”>
  <decoded_as>sshd</decoded_as>
  <description>Logging every decoded sshd message</description>
</rule>
```

Tag `<match></match>` : search part chỉ định trong log --> phát hiện event

```xml
<rule id=“100124” level=“5”>
  <decoded_as>sshd</decoded_as>
  <match>^Failed password</match>
  <description>Failed SSHD password attempt</description>
</rule>
```

Tạo rule tree 

`<if_sid></if_sid>` : chỉ ra 100125 là rule con của 100123
`<group>authentication_success</group>` : Liên kết rule này với group OSSEC HIDS authentication_success
```xml
<rule id=“100125” level=“3”>
  <if_sid>100123</if_sid>
  <match>^Accepted password</match>
  <group>authentication_success</group>
  <description>Successful SSHD password attempt</description>
</rule>
```

1 Tree đầy đủ
- Rule 100123 :Bộ decoder "sshd" mà decode được log mess thì Thông báo "Logging every decoded sshd message"
- Nếu Rulle 100123 được thực thi thì xem xét 2 Rule con là 100124 và 100125. 
```xml
<group name=“syslog,sshd,”>
  <rule id=“100123” level=“2”>
    <decoded_as>sshd</decoded_as>
    <description>Logging every decoded sshd message</description>
  </rule>
  <rule id=“100124” level=“7”>
    <if_sid>100123</if_sid>
    <match>^Failed password</match>
    <group>authentication_failure</group>
    <description>Failed SSHD password attempt</description>
  </rule>
  <rule id=“100125” level=“3”>
    <if_sid>100123</if_sid>
    <match>^Accepted password</match>
    <group>authentication_success</group>
    <description>Successful SSHD password attempt</description>
  </rule>
</group>
```
<img src="..\img\Screenshot_60.png">

<img src="..\img\Screenshot_64.png">
<img src="..\img\Screenshot_63.png">

1 Tree rule khác
- Nếu rule 100124 (bắt event SSh failed) thực thi -> rule 1200126 -> Kiểm tra IP nào ngoài dải 192.168.2.0/24 đăng nhập fail vào server ""main_sys" --> Đẩy cảnh báo
```xml
<rule id=“100126” level=“12”>
  <if_sid>100124</if_sid>
  <group>authentication_failure</group>
  <hostname>main_sys</hostname>
  <srcip>!192.168.2.0/24</srcip>
  <description>Severe SSHD password failure.</description>
</rule>
```
<img src="..\img\Screenshot_65.png">


**NOTE**: tạo các Tree Rule giúp việc phân tích được sâu hơn,  hiệu quả hơn. Phát huy tối đa hiệu quả các rule đơn lẻ


Sử dụng `<time></time>` : chị định khoảng thời gian
- Ví dụ : Cảnh báo những đăng nhập thành công ngoài giờ hành chính (từ 6h tối đến 8h30 sáng)
```xml
<rule id=“100127” level=“10”>
  <if_sid>100125</if_sid>
  <time>6 pm – 8:30 am</time>
  <description>Login outside business hours.</description>
  <group>policy_violation</group>
</rule>
```
<img src="..\img\Screenshot_68.png">

Các điều kiện đơn:

<img src="..\img\Screenshot_66.png">
<img src="..\img\Screenshot_67.png">


**NOTE**: Attacker sẽ thường tấn công vào các khoảng thời gian làm việc hành chính 

Giả dụ ta có 1 con server, ngoài giờ hành chính rất ít khi SSH vào. --> Việc SSH thành công vào con server này ngoài giờ hành chính rất có thể là hành vi của attacker
```xml
<group name=“syslog,sshd,”>
  <rule id=“100123” level=“2”>
    <decoded_as>sshd</decoded_as>
    <description>Logging every decoded sshd message</description>
  </rule>
  <rule id=“100124” level=“7”>
    <if_sid>100123</if_sid>
    <match>^Failed password</match>
    <group>authentication_failure</group>
    <description>Failed SSHD password attempt</description>
  </rule>
  <rule id=“100125” level=“3”>
    <if_sid>100123</if_sid>
    <match>^Accepted password</match>
    <group>authentication_success</group>
    <description>Successful SSHD password attempt</description>
  </rule>
  <rule id=“100130” level=“12”>
    <if_sid>100125</if_sid>
    <time>5:30 pm – 8:30 am</time>
    <description>Accounting access outside of regular business hours.</description>
    <user>abdalahg035</user>
    <group>policy_violation</group>
    <hostname>accounting01</hostname>
  </rule>
</group>
```
Như vậy là cứ 1 phiên SSH thành công trong khoảng 5:30 pm - 8:30 am thì sẽ gửi cảnh báo (mail) (vì level rule = 12 . Level email alert thường ở mức 7,8 )

Dùng `<if_group></if_group>` : để tăng phạm vi
```xml
<rule id=“100127” level=“10”>
  <if_group>successful_login</if_group>
  <time>6 pm – 8:30 am</time>
  <description>Login outside business hours.</description>
  <group>policy_violation</group>
</rule>
```
Vs bất kỳ đăng nhập ngoài giờ hành chính được báo về từ bất kỳ device, agent nào thì cũng tạo alert.

Chỉ 1 alert được generate từ mỗi event

<img src="..\img\Screenshot_69.png">
<img src="..\img\Screenshot_70.png">

## 4.2 Composite Rules (RULE tổng hợp)

Thay vì chỉ ta động đến những sự kiện đơn lẻ. Ta có thể tạo tương quan giữa chúng --> Phù hợp, Chính xác hơn với hoàn cảnh đang diễn ra. 

```xml
<rule id=“100130” level=“10” frequency=“x” timeframe=“y”>
</rule>
```
- frequency : tần số, đếm số lần lặp lại của event
- timeframe : Khoảng thời gian 

( Ví dụ đếm số lượt ssh failed trong khoảng thời gian 10 phút từ 1 IP)

Ví dụ : tạo  rule tổng hợp sẽ tạo alert có mức độ cao hơn nếu 5 lần failed password trong 10 phút

Sử dụng `<if_matched_sid></if_matched_sid>` : chỉ ra rule nào cần seen trong frequency và timeframe để tạo cảnh báo.

```xml
<rule id=“100130” level=“10” frequency=“5” timeframe=“600”>
  <if_matched_sid>100124</if_matched_sid>
  <description>5 Failed passwords within 10 minutes</description>
</rule>
```
Các Tag quan trọng 
<img src="..\img\Screenshot_71.png">

5 lần sai pass trong 10 phút từ cùng 1 source IP thì sẽ alert mức 10
```xml
<rule id=“100130” level=“10” frequency=“5” timeframe=“600”>
  <if_matched_sid>100124</if_matched_sid>
  <same_source_ip />
  <description>5 Failed passwords within 10 minutes</description>
</rule>
```


Sử dụng `<if_matched_ group></if_matched_ group>` thay cho `<if_matched_sid></if_matched_sid>` để mở rộng phạm vi
```xml
<rule id=“100130” level=“10” frequency=“5” timeframe=“600”>
  <if_matched_group>authentication_failure</if_matched_group>
  <same_source_ip />
  <description>5 Failed passwords within 10 minutes</description>
</rule>
```
Xem xét tất cả các xác thực thất bại trên hệ thống. Failed password 5 lần -> bắn alert


Ngoài ra có thể dùng `<if_matched_regex> </if_matched_regex>` để chỉ định các regexp
```xml
<rule id=“100130” level=“10” frequency=“5” timeframe=“600”>
  <if_matched_regex>^Failed password</if_matched_regex>
  <same_source_ip />
  <description>5 Failed passwords within 10 minutes</description>
</rule>
```
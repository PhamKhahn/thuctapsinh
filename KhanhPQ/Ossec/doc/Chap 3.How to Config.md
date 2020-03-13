# Config

# 1.
etc/ossec.conf là file config chính

File dạng XML

`<ossec_config></ossec_config>` là root tag. Các tag con khác nằm trong nó

<img src="..\img\Screenshot_26.png">

<img src="..\img\Screenshot_27.png">

# 2.
## 2.1 B1 : Điều chỉnh khả năng cảnh báo (alert) và log của hệ thống

    - Ossec server có khả năng tạo cảnh báo; lưu log tập trung từ agent
    - Các agent gửi event,log cho Server. Server lấy đi phân tích và tạo cảnh báo
    - Nếu hệ thống lớn, log cần lưu lại -> Ossec có thể kết nối đến db để lưu

## 2.1.1 Cảnh báo mail
Cảnh bảo có mức độ nghiêm trọng chạy từ 0 - 15 ( thấp -> cao)
`<log_alert_level></log_alert_level>` : 
Nếu alert severity level > log_alert_level thì Alert sẽ được lưu vào alerts.log

`<email_alert_level></email_alert_level>` : mức độ mà >= sẽ gửi cảnh báo


```xml
<ossec_config>
  <alerts>
  <log_alert_level>2</log_alert_level>
  <email_alert_level>8</email_alert_level>
  </alerts>
</ossec_config>
```

Có thể ghi toàn bộ log lại (nhưng không nên . CHỉ khi có yêu cầu) -> ảnh hướng dung lượng.
```xml
<ossec_config>
  <global>
  <logall>yes</logall>
  </global>
</ossec_config>
```

### 2.1.1.1 Configuring Email
Config email gửi, nhận trong `<global></global>` -> Cấu hình chung

```xml
<ossec_config>
  <global>
    <email_notification>yes</email_notification>
    <email_to>john@fakeinc.com</email_to>
    <email_to>mike@fakeinc.com</email_to>
    <smtp_server>smtpserver.fakeinc.com</smtp_server>
    <email_from>ossecm@fakeinc.com</email_from>
    <email_maxperhour>20</email_maxperhour>
  </global>
</ossec_config>
```
- Cho phép gửi email
- Gửi đến john@fakeinc.com và mike@fakeinc.com
- smtp server : smtpserver.fakeinc.com  

        Trong trường hợp cài Postfix để gửi qua gmail trên chính máy Ossec server thì điền "localhost"

- Gửi từ ossecm@fakeinc.com
- Không gửi quá 20 mail/1h . Quá 20 mail sẽ dồn lại gửi khi hết giờ.


## 2.1.1.2 Granular Email Configuration
Cấu hình riêng lẻ,chi tiết
 
```xml
<ossec_config>
  <email_alerts>
  <email_to>peter@fakeinc.com</email_to>
  <group>apache</group>
  </email_alerts>
</ossec_config>
```
Gửi mail alert của group apache đến peter@fakeinc.com (ng quản trị webserver)

Ngoài ra có thể gửi qua SMS.

## 2.2. Nhận event log thông qua Syslog/Rsyslog

```xml
<ossec_config>
  <remote>
    <connection>secure</connection>
  </remote>
</ossec_config>
```
Có thể chỉ định IP/ dải network được phép kết nối:
```xml
<ossec_config>
  <remote>
    <connection>secure</connection>
    <allowed-ips>192.168.10.0/24</allowed-ips>
  </remote>
</ossec_config>
```

Log đưa qua syslog thì cần chỉ rõ:
```xml
<ossec_config>
  <remote>
    <connection>syslog</connection>
    <allowed-ips>192.168.2.0/24</allowed-ips>
    <allowed-ips>192.168.1.0/24</allowed-ips>
  </remote>
</ossec_config>
```
(Cài server thì mặc định có "secure" (log đến từ remote agent) . Chỉ cần thêm syslog vào. không cần xóa phần tag đã có của secure)

## 2.3 Config đẩy ra Database
Ossec không yêu cầu phải có DB thì mới hoạt động được nhưng nếu các cảnh báo được lưu lại thì là 1 điều tốt. Có thể xem lại.

`<page 75-76 Ossec HIDS>`

# 3. Khai báo các file rule
Xác định bởi tag `<rules></rules>`
- Khai báo rule được load khi Ossec start
- Thường thì không cần thay đổi những config mặc định
- Tên rule đặt trong tag `<include></include>`
- Các rule lưu tại /var/ossec/rules

```xml
<ossec_config> <!– rules global entry –>
  <rules>
    <include>rules_config.xml</include>
    <include>pam_rules.xml</include>
    <include>sshd_rules.xml</include>
  </rules>
<ossec_config>

```
# 4. Đọc các file Log
Sẽ có các file được mặc định monitor, nhưng ta cần monitor thêm các file khác

Đặt trong tag `<localfile></localfile>`

```xml 
<ossec_config>
  <localfile>
    <log_format>syslog</log_format>
    <location>/var/log/messages</location>
  </localfile>
</ossec_config>
```
- log fomat là syslog
- file log nằm ở /var/log/messages

```
<ossec_config>
  <localfile>
    <log_format>apache</log_format>
    <location>/var/www/logs/server1/error_log</location>
  </localfile>
</ossec_config
```
- log format là apache
- file log nằm ở /var/www/logs/server1/error_log

**NOTE** : Nếu log ghi theo từng dòng thì có thể sử dụng "**syslog**" thay thế

<img src="..\img\Screenshot_28.png">

<img src="..\img\Screenshot_29.png">

# 5. Config Kiểm tra toàn vẹn
Integrity checking có thể được enabled trên cả server và agent

tag `<frequency>  </frequency>` : tần số quét (tính bằng giây) để tìm sự thay đổi trên các folder được chỉ định.

tag `<directories></directories>` :  liệt kê các thư mục cần theo dõi

tag `<ignore></ignore>` : bỏ qua các file/dir từ file integrity
checks

<img src="..\img\Screenshot_30.png">

<img src="..\img\Screenshot_31.png">


Config mặc định trên Linux
```xml
<ossec_config>
  <syscheck>
    <frequency>86400</frequency>
    <directories check_all=“yes”>/etc,/usr/bin,/usr/sbin</directories>
    <directories check_all=“yes”>/bin,/sbin</directories>
    <ignore>/etc/mtab</ignore>
    <ignore>/etc/mnttab</ignore>
  </syscheck>
</ossec_config>
```

# 6. Config 1 Agent
Agent không thực hiện bất cứ việc phân tích hay xử lý cảnh báo nào.

Tất cả chuyển về Server xử lý và tạo cảnh báo.

Trên Agent sửa file ossec-agent.conf
```
<ossec_config>
  <client>
    <server-ip>192.168.1.1</server-ip>
    <port>1519</port>
  </client>

</ossec_config>
```

- Chỉ định ip server và port (Nếu không khai báo port thì mặc định là 1514)
- Có thể khai báo hostname server bằng  `<server-hostname></server-hostname>` để thay cho IP. Nếu nó đủ điều kiện.

# 7. Configuring Advanced Options
File  **internal_options.conf**

(Hiếm khi phải sửa đổi)

Cẩn thận khi config nó. Nó chịu trách nhiệm nhiệm cho việc cấu hình runtime 
--> Lỗi --> Khiến Agent hoặc Server không khởi động được cấu hình đúng

<img src="..\img\Screenshot_31.png">
<img src="..\img\Screenshot_32.png">
<img src="..\img\Screenshot_33.png">
<img src="..\img\Screenshot_34.png">
<img src="..\img\Screenshot_35.png">
<img src="..\img\Screenshot_36.png">


**NOTE** : Nên backup file config trước khi sửa đổi nó.



# Lưu ý, tổng kết
Với file config:
- Hạn chế sửa  internal_options.conf
- backup file config trước khi sửa đổi

Email alert bao gồm: 
-  location, filename, description, rule level, rule description, rule id, event time và the log (or message) 


Log trong DB không được mã hóa

Rule bị load fail sẽ báo về log trong ossec.log
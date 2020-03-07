# Tạo, thêm 1 rule

Đoạn văn bản nằm giữa `<!--và -->` được tính là comment

# 1. Tạo custom decoder và rule
## 1.1 Thêm file để monitor
```
<localfile>
    <location>/var/log/messages</location>
    <log_format>syslog</log_format>
</localfile
```
# ossec.conf
## 1. Localfile options
`<localfile>` có sẵn trên cả 
- server
- agent

Tất cả tùy chọn localfile phải được config ở **/var/ossec/etc/ossec.conf** hoặc **/var/ossec/etc/shared/agent.conf** và được đặt trong tag `<ossec_config>` hoặc `<agent_config>`

```
<ossec_config>
    <localfile>
        <!--
        Localfile options here
        -->
    </localfile>
</ossec_config>
```

### OPTION
Các option thường gặp

- localfile
- location
    
    Chỉ định vị trí log được đọc.
    Có thể dùng ký tự đại diện.
    Ví dụ:các log có dạng file.log-2011-01-22 --> ta có thể sử dụng file.log-%Y-%m-%d để bắt tất cả các log theo định dạng

    CHú ý: Ossec-logcollector khi khởi động chỉ bắt các file log đã tồn tại.Nó không tự động bắt các log được tạo sau đó

    Allowed: bất kỳ log file nào


- log_format

    - Định dạng log được đọc

    - Nếu log là entry theo từng dòng thì sử dụng "syslog"

    Default: syslog

Ngoài ra còn các tùy chọn format khác( như ở trên Win,..) và 1 số Option khác như (command,frequency,check_diff):

http://www.ossec.net/docs/docs/syntax/head_ossec_config.localfile.html#element-command

## 1.2 Tạo Decoder
Thêm vào file **local_decoder.xml** đặt trong **/var/ossec/etc**
Mẫu một custom decoder
```xml
<decoder name="atomic-widget-login">
  <parent>atomic-widget</parent>
  <regex>user=(\S+)</regex>
  <order>srcuser</order>
  <fts>srcuser</fts>
```

Xem thêm về Syntax của decoder tại:

http://www.ossec.net/docs/docs/syntax/head_decoders.html


Ví dụ: 
Có log sau
```
2013-11-01T10:01:04.600374-04:00 arrakis ossec-exampled[9123]: test connection from 192.168.1.1 via test-protocol1

2013-11-01T10:01:05.600494-04:00 arrakis ossec-exampled[9123]: successful authentication for user test-user from 192.168.1.1 via test-protocol1
```
Log đầu tiên có thể tách thành:
- 2013-11-01T10:01:04.600374-04:00 : timestamp từ rsyslog
- arrakis  : hostname của hệ thống
- ossec-exampled : daemon tạo log
- [9123] : Process ID của ossec-exampled instance
- test connection from 192.168.1.1 via test-protocol1 : Đây là log mess



Dùng **ossec-logtest** cho ta kết quả tương tự:

<img src="..\img\Screenshot_22.png">

Hiển thị là không decoder matched

--> Cần tạo 1 decoder cho log này

Ta tạo 1 decoder để bắt tất cả log phát sinh từ **program_name: 'ossec-exampled'**

```xml
<decoder name="ossec-exampled">
  <program_name>ossec-exampled</program_name>
</decoder>
```

<img src="..\img\Screenshot_23.png">

Lúc này Phase 2 đã xác định được log đến từ ossec-exampled. Vẫn còn 1 vài thông tin quan trọng như IP và "test-protocol1"--> ta tạo 1 decoder

```
<decoder name="ossec-exampled-test-connection">
  <parent>ossec-exampled</parent>
  <prematch offset="after_parent">^test connection </prematch> <!-- offset="after_parent" makes OSSEC ignore anything matched by the parent decoder and before -->
  <regex offset="after_prematch">^from (\S+) via (\S+)$</regex> <!-- offset="after_prematch" makes OSSEC ignore anything matched by the prematch and earlier-->
  <order>srcip, protocol</order>
</decoder>
```


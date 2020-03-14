# Tìm hiểu về hệ thống phát hiện xâm nhập Ossec [part 1]
Nghe tiêu đề thôi thì tôi đoán bạn cũng mường tượng ra chức năng của Ossec rồi đúng không? Hãy để tôi giới thiệu chi tiết hơn về nó - một công cụ vô cùng hữu ích và mạnh mẽ

Nhưng trước hết hãy nói qua một chút khái niệm về IDS nhé
## I. Tổng quan về IDS
### 1. Hệ thống phát hiện xâm nhập IDS
IDS là hệ thống phát hiện các dấu hiệu của tấn công xâm nhập, đồng thời có thể khởi tạo các hành động trên thiết bị khác để ngăn chặn tấn công. 

Khác với firewall, IDS không thực hiện các thao tác ngăn chặn truy nhập mà chỉ theo dõi các hoạt động trên mạng để tìm ra các dấu hiệu của tấn công và cảnh báo cho người quản trị mạng. 

Một điểm khác biệt khác đó là mặc dù cả hai đều liên quan đến bảo mật mạng, nhưng firewall theo dõi sự xâm nhập từ bên ngoài và ngăn chặn chúng xảy ra, nó giới hạn truy nhập giữa các mạng để ngăn chặn sự xâm nhập nhưng không phát hiện được cuộc tấn công từ bên trong mạng. Còn IDS sẽ đánh giá sự xâm nhập đáng ngờ khi nó đã diễn ra đồng thời phát ra cảnh báo, nó theo dõi được các cuộc tấn công có nguồn gốc từ bên trong một hệ thống. 

Chức năng ban đầu của IDS chỉ là phát hiện các dấu hiện xâm nhập, do đó IDS chỉ có thể tạo ra các cảnh báo tấn công khi tấn công đang diễn ra hoặc thậm chí sau khi tấn công đã hoàn tất. Càng về sau, nhiều kỹ thuật mới được tích hợp vào IDS, giúp nó có khả năng dự đoán được tấn công (prediction) và thậm chí phản ứng chủ động khi cuộc tấn công diễn ra (Active response).
 
### 1. HIDS và NIDS
<img src="..\Ossec\IDS.gif">

Trước khi  nói về Ossec, tôi muốn bạn biết thêm về 2 khái niệm này:
- **Network-based IDS (NIDS)**: Là những IDS giám sát trên toàn bộ mạng. Nguồn thông tin chủ yếu của NIDS là các gói dữ liệu đang lưu thông trên mạng. NIDS thường được lắp đặt tại ngõ vào của mạng, có thể đứng trước hoặc sau firewall.

- **Host-based IDS (HIDS)**: Là những IDS giám sát hoạt động của từng máy tính riêng biệt. Do vậy, nguồn thông tin chủ yếu của HIDS ngòai lưu lượng dữ liệu đến và đi từ máy chủ còn có hệ thống dữ liệu nhật ký hệ thống (system log) và kiểm tra hệ thống (system audit).

## II. Giới thiệu về Ossec - một trong các HIDS tools tốt nhất trên nhất trên thế giới
Không ngoa đâu khi tôi nói Ossec như vậy.

Bạn hãy thử bật 1 Tab mới trên Web Browser của mình  và search "The The best hids tools". Bạn sẽ thấy rằng không một kết quả tìm kiếm nào thiếu đi cái tên Ossec trong đó và vị trí của nó thì luôn nằm ở top trên.

Vậy thì tại sao ?
### 1. Ossec là gì?
OSSEC là phần mềm mã nguồn mở giúp phát hiện xâm nhập dựa trên host (HIDS); 
ó đa nền tảng có thể mở rộng và có nhiều cơ chế bảo mật khác nhau.

### 2. Tính năng 
- Log based Intrusion Detection (LIDs) : Chủ động theo dõi và phân tích dữ liệu real-time từ nhiều nguồn sinh log.

- Compliance Auditing : Kiểm soát các ứng dụng và hệ thống nhằm tuân thủ các yêu cầu, tiêu chuẩn về bảo mật như PCI-DSS và CIS.

- Rootkit and Malware Detection : Phân tích ở cấp độ file và tiến trình nhằm phát hiện các ứng dụng độc hai và các rootkit.

- File Integrity Monitoring (FIM) : Phát hiện các thay đổi đối với hệ thống.

- Active Response : Các hành vi ứng phó lại các cuộc tấn công vào hệ thống trong thời gian thực.

- System Inventory : Thu thập các thông tin hệ thống như phần mềm được cài đặt, harward,...

### 3. Điểm nổi trội 
- Đa nền tảng (Linux, Mac OS , Window,Solaris)
- Cho phép cấu hình việc cảnh báo 
- Real-time Alert (Cảnh báo thời gian thực)
    
    - Kết hợp với smtp,sms,syslog sẽ cho phép người dùng nhận cảnh báo trên các thiết bị có hỗ trợ email

    - Ngoài ra tính năng Active-respone có thể giúp block 1 cuộc tấn công ngay lập tức.

- Có thể tích hợp với các hệ thống hiện đại (SIM/SEM)

- Mô hình Client - Server, cho phép Server dễ dàng quản lý tập trung các chính sách trên nhiều OS.

- Giám sát trên agent, agentless (Client không cài đặt được gói agent) như router, firewall

### 4. Kiến trúc và mô hình hoạt động của Ossec
Ossec hoạt động theo mô hình Client - Server

<img src="..\Ossec\Kien_truc1.png"> 
<img src="..\Ossec\Kientruc2.png">


**5.1. Manager (Server)**

Lưu trữ cơ sở dữ liệu của việc kiểm tra tính toàn vẹn file; kiểm tra các log, event.

Quản lý, lưu tất cả các rule, decoder (bộ giải mã), cấu hình chính. Điều này giúp dễ dàng quản lý, dù cho có lượng lớn agent

Server không chạy trên Windows OS.

**5.2. Agent**

Bản chất thì là 1 phần mềm được cài đặt trên máy client giúp thu thập các thông tin và gửi cho Server để phân tích, thống kê. 
- Chiếm lượng memory và CPU nhỏ,không đáng kể

- 1 số thông tin được thu thập theo thời gian thực

- 1 số thông tin thì lại được thu thập định kỳ

Nhưng khi nói Agent thì là để chỉ máy Client được cài agent.

Chú ý: 
- Windows chỉ có thể làm Agent chứ không làm Server được.

**5.3 Agentless**

Là các hệ thống không cài được gói agent

Trên các Agentless này có thể thực hiện việc kiểm tra tính toàn vẹn

Giúp monitor firewall, router hay thậm chí cả hệ thống Unix

**5.4 Ảo hóa/ VMware**

Cho phép cài đặt agent trên các guest OS (Máy ảo)

Ngoài ra cũng được cài đặt trong VMware ESX nhưng có thể dẫn đến sự cố không hỗ trợ.

Khi cài đặt trong VMware ESX giúp nhận được thời điểm các VM guest được khởi tạo, xóa đi, khởi động,.. Ossec cũng giám sát việc login,logouts và các lỗi bên trong ESX server

Ngoài ra nó cũng cảnh báo nếu bất kỳ tùy chọn cấu hình không an toàn nào được bật.

**5.5 Firewalls, switches and routers**

Ossec có thể nhận và phân tích nhật ký hệ thống từ nhiều firewall, switch, router.

Nó support tất cả Cisco routers, Cisco PIX, Cisco FWSM, Cisco ASA, Juniper Routers, Netscreen firewall, Checkpoint và nhiều thiết bị khác.

Bạn có thể tham khảo danh sách các hệ điều hành/ thiết bị được hỗ trợ tại đây:

https://www.ossec.net/docs/docs/manual/supported-systems.html

## III. Tổng kết 
Qua bài này, tôi hy vọng mình đã đưa được đến các bạn thêm những thông tin về một công cụ vô cùng hữu ích đối với những nhà quản trị hệ thống trong việc quản lý, giám sát, phát hiện những xâm nhập, thay đổi bất thường trên hệ thống.

"Hệ thống phát hiện xâm nhập" nghe khoai vậy thôi chứ Ossec không hề khó để tiếp cân.

Ở các bài tiếp theo, tôi sẽ cùng bạn triển khai, khám phá các thành phần, tính năng của Ossec. 

Cảm ơn các bạn đã đọc hết bài viết !!!


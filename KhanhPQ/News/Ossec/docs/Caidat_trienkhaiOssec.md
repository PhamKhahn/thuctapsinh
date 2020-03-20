# [Ossec – Part 2] Cài đặt và triển khai Ossec
Ở phần trước, chúng ta đã cùng nhau tìm hiểu sơ qua về Ossec - một HIDS mạnh mẽ.

Phần này, tôi sẽ giúp bạn cài đặt và triển khai Ossec với mô hình Server-Agent

# I. Mô hình
<img src="..\imgs\Screenshot_6.png">

- Ta sử dụng mô hình Server-Agent:

<img src="..\imgs\Screenshot_7.png">

Với:

- Server:
    ```
        OS : CentOS 7
        IP : 10.10.34.111/24
    ```

- Agent:

    ```
        OS : CentOS 7
        IP : 10.10.34.112/24
    ```
# II. Cài đặt
## **1. Ossec Server**
**B1**: Cài đặt các pacakage hỗ trợ trước khi cài đặt ossec

```
yum install -y epel-release zlib-devel pcre2-devel make gcc mysql-devel postgresql-devel sqlite-devel
```

sqlite-devel : Với version 3.0 thì cần package này để sử dụng tính năng SQLite 

**B2**: Cài đặt ossec-server
```
yum install -y wget
```

Thêm repo AtomiCorp: 
```
wget -q -O - https://updates.atomicorp.com/installers/atomic | sh
```

Cài đặt Ossec-server
```
yum install ossec-hids ossec-hids-server
```

## **2. Ossec Agent**
**B1**: Cài đặt các pacakage hỗ trợ trước khi cài đặt ossec

```
yum install -y epel-release zlib-devel pcre2-devel make gcc mysql-devel postgresql-devel sqlite-devel
```

sqlite-devel : Với version 3.0 thì cần package này để sử dụng tính năng SQLite 

**B2**: Cài đặt ossec agent
```
yum install -y wget
```

Thêm repo AtomiCorp: 
```
wget -q -O - https://updates.atomicorp.com/installers/atomic | sh
```

Cài đặt Ossec-agent
```
yum install ossec-hids ossec-hids-agent
```

# III. Kết nối Server-Agent
Để kết nối Agent đến Server ta có thể sử dụng **manage_agents** (1 executable file nhằm cung cấp interface để thực hiện xử lý khóa xác thực cho các Ossec agent)

Các bước tiến hành:
- Chạy manage_agents trên Ossec Server
    - Add Agent mới
    - Extract key cho Agent đó
- Chạy manage_agents trên Ossec Agent
    - Import key đã Extract từ Server
- Restart tiến trình quản lý Ossec (Trên Server)
- Start Agent mới

## 1. manage_agents trên OSSEC server

**manage_agents** trên OSSEC server cũng cấp giao diện giúp :
- Add 1 Ossec Agent vào Server
- Extract key cho Agent đó để có thể được add vào Server
- Remove 1 Agent từ Server
- List ra tất cả Agent có thể được add vào Server

**B1: Chạy manage_agents**

*Chú ý:  manage_agents nên được chạy ở quyền root*

```
/var/ossec/bin/manage_agents
```
Giao diện có dạng: 
```
****************************************
* OSSEC HIDS v2.5-SNP-100809 Agent manager.     *
* The following options are available: *
****************************************
   (A)dd an agent (A).
   (E)xtract key for an agent (E).
   (L)ist already added agents (L).
   (R)emove an agent (R).
   (Q)uit.
Choose your action: A,E,L,R or Q:
```

**B2: Add 1 agent mới** 
```
Choose your action: A,E,L,R or Q: A
```

- **B2.1: Đặt tên cho Agent mới**

    ```
    - Adding a new agent (use '\q' to return to the main menu).
    Please provide the following:
    * A name for the new agent: agent_34_0
    ```

- **B2.2: Chỉ định IP cho Agent**
    - Có thể là single IP  - Nhưng nó phải là duy nhất.
    - Hoặc sử dụng 1 dải IP hoặc **any** : nếu IP của Agent có thể thay đổi thường xuyên. 
    - Việc trùng lặp IP sẽ gây ra nhiều vấn đề

    ```
    * The IP Address of the new agent: 10.10.34.0/24
    ```

- **B2.3: Đặt ID cho Agent**
    - manage_agents sẽ gợi ý ID phù hợp, bắt đầu từ 001 với Agent đầu tiên.
    - 000 là cho Server. 

    ```
    * An ID for the new agent[002]: 1033
    ```
    ```
    Agent information:
    ID:1033
    Name:agent_34_0
    IP Address:10.10.34.0/24

    Confirm adding it?(y/n): y
    Agent added
    ```


 **Kết quả**

<img src="..\imgs\Screenshot_01.png">


**B3 : Extract key cho Agent đã tạo**
- Sau khi add 1 agent, cần tạo key cho agent đó.
- Key này cần được copy tới agent

    <img src="..\imgs\Screenshot_1.png">

 


## 2. manage_agents trên  OSSEC Agent
Việc add Agent trên Server là chưa đủ, muốn connect Server và Agent thì cần Import key Server đã tạo cho Agent vào chính máy Agent 

**B1: Chạy file manage_agents**

```
/var/ossec/bin/manage_agents
```

- Chọn "I" và thực hiện import key đã được extract từ Server

 <img src="..\imgs\Screenshot_2.png">

**B2: Config IP server mà agent sẽ connect**

<img src="..\imgs\Screenshot_5.png">

**CHÚ Ý**: Có thể ở bước này sẽ xảy ra lỗi
```
manage_agents: ERROR: Cannot unlink /queue/rids/sender: No such file or directory
```
Cách fix:
```
cd /var/ossec/queue/rids/ 
cp 001 sender
```
(Thay 001 bằng file sẽ xuất hiện trong rids của bạn. Như tôi thì là 1033).

Sau đó Import Key lại bình thường

**B3: 
Để thay đổi có hiệu lực**
- Restart server
    ```
    /var/ossec/bin/ossec-control restart
    ```
- Start Agent (Nếu đã start rồi thì ta restart)
    ```
    /var/ossec/bin/ossec-control restart
    ```
    **NOTE :** Có thể bạn sẽ gặp thông báo lỗi config ở file */var/ossec/etc/shared/agent.conf*

    Cụ thể lỗi dạng :
    ```
    Duplicated directory given: '/etc'...
    ```
    Lỗi này do trùng lặp config với file config chính của Ossec Agent.

    *Cách fix*:
    ```
    cd /var/ossec/etc/shared/
    cp agent.conf agent.conf.bk
    rm -rf agent.conf
    ```

    Sau khi tạo backup và xóa file này đi rồi thì restart lại.

**Check kết quả** 
<img src="..\imgs\Screenshot_4.png">



==============================================================

# NOTE
- Nhớ mở port để Server có thể giao tiếp với Agent
    
   ```
   firewall-cmd --permanent --add-port=1514/udp
   firewall-cmd --reload
   ```

## IV. Tổng kết
Như vậy tôi đã giới thiệu cho bạn cách để kết nối 1 Agent đến Server

Tức là đặt Agent đó dưới sự kiểm soát,bảo vệ của Ossec HIDS Server.

Tuy nhiên, chúng ta sẽ không chỉ dừng lại ở đây. Có khá nhiều bài toán đặt ra:
- Nếu có rất nhiều Agent thì sao. Chẳng lẽ ta phải lặp đi lặp lại từng đó thao tác với mỗi Agent ?
- Làm sao bạn có thể nhận cảnh báo qua mail mà không cần vào trực tiếp file log cảnh báo của Ossec Server để xem ?
- Quá nhiều cảnh báo bắn về email thì phải làm sao ?

    **...**

Những bài toán đó, chúng ta sẽ lần lượt giải quyết khi đi tới tìm hiểu nhưng thành phần cốt lõi tạo nên Ossec.

Cảm ơn bạn đã xem hết bài viết của tôi.

Chúc bạn thành công!!!
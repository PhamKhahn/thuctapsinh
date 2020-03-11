# Mức cảnh báo 
severities (levels) chạy từ 0 đến 15 ( tắng dần mức nghiêm trọng)

Khi viết rule -> đặt level -> lưu trữ phân cấp theo level -Các rule có level cao hơn được đánh giá trước.

Ngoại lệ, mức 0 được đánh giá trước tất cả mức khác.

- Level 0: Ignored, no action taken

        quét đầu tiên.chủ yếu để tránh cảnh báo giả, không liên quan đến bảo mật
- Level 2: System low priority notifi cation

        Thông báo hệ thống hoặc thông báo trạng thái không liên quan đến bảo mật

- Level 3: Successful/authorized events

        Đăng nhập thành công, tường lửa cho phép các sự kiện nào đó, vv

- Level 4: System low priority errors (lỗi hệ thống có mức ưu tiên thấp)

        Lỗi liên quan đến cấu hình sai hoặc các thiết bị/phân mềm không sử dụng nữa

        Không liên quan tới bảo mật, thường bị gây ra do cài đặt mặc định / testing

- Level 5: User-generated errors (lỗi do ng dùng)

       Quên password, Hành động bị từ chối --> Thường không liên quan đến bảo mật

- Level 6: Low relevance attack (Có dấu hiệu tấn công mức thấp)

        Ví dụ : Chỉ ra 1 con worm/virus nhưng chúng không gây ra đe dọa cho hệt thống. Kiểu như 1 còn worm Windown nhưng đang nằm trên Server Linux (nó không có tác dụng gì)
- Level 9: Error from invalid source (lỗi từ nguồn không hợp lệ)

        Chỉ ra các nỗ lực login từ các unknown user hoặc từ 1 nguồn không hợp lệ

        Nếu chúng lặp lại nhiều lần --> Có thể liên quan đến vấn đề an ninh/bảo mật

        Cũng bao gồm các lỗi của tài khoản admin hay root

- Level 10: Multiple user generated errors

        Bao gồm nhiều bad password, nhiều login failed

        --> Cót thể chỉ ra 1 cuộc tấn công hoặc cũng có thể là do ng dùng quên thông tin đăng nhập

- Level 12: High-importance event 

        Các thông báo lỗi/ cảnh báo từ hệ thống, kernel

        --> Có thể chỉ ra 1 cuộc tấn công vào 1 application cụ thể

- Level 13: Unusual error (high importance) _Lỗi bất thường

        Tấn công tràn bộ đệm
        Lượng log hoặc chuỗi URL lớn hơn mức bình thường

- Level 14: High importance security event.

        Kết quả của sự liên quan/tường quan giữa nhiều attack rule. Biểu thị một cuộc tấn công 
- Level 15: Attack successful

        Cần chú ý, quan tâm vấn đề này ngay lập tức. Phần trăm thông báo giả rất nhỏ.


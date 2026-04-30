-- ============================================================
-- FILE: database/doan_nodejs_nhom5.sql
-- MỤC ĐÍCH: Toàn bộ SQL để tạo database, bảng và dữ liệu mẫu
-- CÁCH DÙNG:
--   - MariaDB/MySQL: mysql < database/doan_nodejs_nhom5.sql
--   - Hoặc copy-paste vào phpMyAdmin
--   - Hoặc chạy: npm run seed (tự động)
-- ============================================================

-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th4 30, 2026 lúc 12:07 AM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

-- ============================================================
-- BƯỚC 1: TẠO DATABASE NẾU CHƯA TỒN TẠI
-- ============================================================
-- CREATE DATABASE IF NOT EXISTS: Tạo DB nếu chưa có, không lỗi nếu đã có
-- CHARACTER SET utf8mb4: Hỗ trợ emoji, ký tự unicode đầy đủ
-- COLLATE utf8mb4_vietnamese_ci: Sắp xếp theo tiếng Việt, không phân biệt hoa/thường
CREATE DATABASE IF NOT EXISTS `doan_nodejs_nhom5` 
CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci;

-- Sử dụng database vừa tạo
USE `doan_nodejs_nhom5`;

-- ============================================================
-- Cơ sở dữ liệu: `doan_nodejs_nhom5`
-- ============================================================

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `articles`
-- BÀI VIẾT (NEWS ARTICLES)
-- Lưu trữ tất cả bài viết/tin tức của website
-- Mỗi bài viết thuộc về 1 danh mục (category_id)
--

CREATE TABLE `articles` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,                    -- FK -> categories.id (Danh mục bài viết)
  `title` varchar(255) NOT NULL,                    -- Tiêu đề bài viết (tối đa 255 ký tự)
  `slug` varchar(255) DEFAULT NULL,                 -- URL-friendly name (ví dụ: ten-bai-viet)
  `thumbnail` varchar(255) DEFAULT NULL,            -- Đường dẫn hình ảnh đại diện
  `content` text DEFAULT NULL,                      -- Nội dung đầy đủ (HTML)
  `summary` text DEFAULT NULL,                      -- Tóm tắt bài viết (hiển thị ở danh sách)
  `author` varchar(100) DEFAULT NULL,               -- Tên tác giả
  `published_date` datetime DEFAULT current_timestamp(), -- Ngày đăng bài
  `views` int(11) DEFAULT 0                         -- Số lượt xem (dùng để sắp xếp "Xem nhiều nhất")
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `categories`
-- DANH MỤC (CATEGORIES)
-- Lưu trữ các danh mục bài viết (Chính trị, Kinh doanh, v.v.)
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,                     -- Tên danh mục
  `slug` varchar(100) DEFAULT NULL,                 -- URL-friendly name
  `description` text DEFAULT NULL                   -- Mô tả danh mục
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

-- ============================================================
-- BƯỚC 2: INSERT DỮ LIỆU MẪU - CATEGORIES (DANH MỤC)
-- ============================================================
-- Chèn 6 danh mục bài viết mẫu
-- slug: Được tạo từ name, dùng cho URL thân thiện (ví dụ: /category/chinh-tri)
-- Kiến thức: Slug không dấu, không space, toàn bộ viết thường, dùng dấu gạch nối
INSERT INTO `categories` (`id`, `name`, `slug`, `description`) VALUES
(1, 'Chính Trị', 'chinh-tri', 'Tin tức về chính trị trong nước và quốc tế'),
(2, 'Kinh Doanh', 'kinh-doanh', 'Tin tức kinh tế, tài chính, thị trường chứng khoán'),
(3, 'Sức Khỏe', 'suc-khoe', 'Tin tức về y tế, sức khỏe, đời sống'),
(4, 'Công Nghệ', 'cong-nghe', 'Tin tức công nghệ, AI, blockchain, startup'),
(5, 'Giáo Dục', 'giao-duc', 'Tin tức giáo dục, tuyển sinh, học bổng'),
(6, 'Thể Thao', 'the-thao', 'Tin tức thể thao, bóng đá, Olympic');

-- ============================================================
-- BƯỚC 3: INSERT DỮ LIỆU MẪU - ARTICLES (BÀI VIẾT)
-- ============================================================
-- Chèn 12 bài viết mẫu (2-3 bài cho mỗi danh mục)
-- thumbnail: Đường dẫn hình ảnh từ thư mục /public/img
-- summary: Đoạn tóm tắt bài viết (hiển thị ở danh sách)
-- content: Nội dung đầy đủ của bài viết
-- published_date: Ngày đăng bài
-- views: Số lượt xem
INSERT INTO `articles` (`id`, `category_id`, `title`, `slug`, `thumbnail`, `content`, `summary`, `author`, `published_date`, `views`) VALUES
(1, 1, 'Chiến lược phát triển kinh tế xanh 2026', 'chien-luoc-phat-trien-kinh-te-xanh-2026', '/img/news-800x500-1.jpg', '<p>Chiều 28/4, tại Hà Nội, Bộ Kế hoạch và Đầu tư đã công bố Chiến lược phát triển kinh tế xanh giai đoạn 2026-2030. Chiến lược này nhằm mục tiêu giảm phát thải khí nhà kính, bảo vệ môi trường và phát triển bền vững.</p><p>Theo Bộ trưởng Lê Minh Hoan, chiến lược này sẽ là nền tảng cho các doanh nghiệp Việt Nam cạnh tranh trên thị trường quốc tế. Các mục tiêu cụ thể bao gồm tăng cường tái chế, phát triển năng lượng tái tạo, và xây dựng các thành phố xanh.</p>', 'Chiến lược phát triển kinh tế xanh 2026-2030 được công bố nhằm mục tiêu phát triển bền vững', 'Nguyễn Văn A', '2026-04-28 10:30:00', 2540),
(2, 2, 'Thị trường chứng khoán Việt Nam tăng trưởng mạnh mẽ', 'thi-truong-chung-khoan-tang-truong', '/img/news-800x500-2.jpg', '<p>Tuần giao dịch từ 22-26/4, chỉ số VN-Index tăng 3.2% lên mức 1.245 điểm. Nhà đầu tư nước ngoài liên tục mua ròng, với tổng giá trị mua ròng đạt 850 tỷ đồng.</p><p>Các cổ phiếu hàng đầu như VCB, BID, GAS đều có những phiên tăng trưởng ấn tượng. Chuyên gia cho rằng, sự tăng trưởng này phản ánh sự lạc quan của thị trường về triển vọng kinh tế trong năm 2026.</p>', 'VN-Index tăng 3.2% lên 1.245 điểm trong tuần qua', 'Trần Thị B', '2026-04-26 14:15:00', 1890),
(3, 3, 'Cảnh báo bệnh sốt xuất huyết gia tăng vào mùa hè', 'canh-bao-sot-xuat-huyet-mua-he', '/img/news-700x435-1.jpg', '<p>Bộ Y tế phát cảnh báo về nguy cơ gia tăng bệnh sốt xuất huyết khi mùa hè đến. Từ đầu năm 2026 đến nay, đã có trên 5.000 ca mắc và 15 ca tử vong.</p><p>Chuyên gia khuyên cách phòng chống: sử dụng mũi nhọn để diệt muỗi, vệ sinh nhà cửa, và tiêm vaccine nếu có điều kiện. Người dân cần chủ động phòng ngừa, đặc biệt là trẻ em và người già.</p>', 'Số ca sốt xuất huyết gia tăng, Bộ Y tế kêu gọi phòng chống', 'Lê Văn C', '2026-04-25 09:45:00', 1245),
(4, 4, 'OpenAI công bố GPT-5: Trí tuệ nhân tạo vượt kỳ vọng', 'openai-cong-bo-gpt-5', '/img/news-700x435-2.jpg', '<p>Hôm nay, OpenAI chính thức công bố GPT-5, phiên bản mới nhất của mô hình ngôn ngữ lớn. GPT-5 có khả năng xử lý 1 triệu token (gấp 10 lần GPT-4), hiểu bối cảnh tốt hơn, và đưa ra câu trả lời chính xác hơn.</p><p>Theo nhận xét của các chuyên gia, GPT-5 là một bước tiến lớn trong lĩnh vực AI. Công ty có kế hoạch cung cấp API cho các doanh nghiệp sử dụng từ tháng 5/2026.</p>', 'OpenAI phát hành GPT-5 với khả năng xử lý gấp 10 lần GPT-4', 'Phạm Minh D', '2026-04-27 16:20:00', 3450),
(5, 5, 'Kỳ thi THPT Quốc gia 2026: Những thay đổi nổi bật', 'ky-thi-thpt-quoc-gia-2026', '/img/news-700x435-3.jpg', '<p>Bộ GD&ĐT vừa công bố phương án tổ chức kỳ thi THPT Quốc gia năm 2026. Năm nay, có một số thay đổi đáng chú ý: giảm số lượng môn thi bắt buộc, tăng cơ hội cho học sinh chọn lựa.</p><p>Kỳ thi dự kiến tổ chức từ 20-22/8/2026. Học sinh được phép thi lại để nâng cao điểm số. Việc này nhằm giảm áp lực, tạo điều kiện học tập linh hoạt hơn cho học sinh.</p>', 'Kỳ thi THPT Quốc gia 2026 có nhiều thay đổi mới', 'Võ Thu E', '2026-04-24 11:00:00', 980),
(6, 6, 'Bóng đá Việt Nam chuẩn bị cho vòng loại World Cup 2026', 'bong-da-viet-nam-world-cup-2026', '/img/news-700x435-4.jpg', '<p>Đội tuyển bóng đá Việt Nam đang tích cực chuẩn bị cho vòng loại World Cup 2026. Huấn luyện viên trưởng Philippe Troussier vừa công bố danh sách 25 cầu thủ tham dự vòng tập trung tại Thái Lan.</p><p>Việt Nam nằm trong bảng A cùng với Nhật Bản, Australia, Oman, Iraq, và Uzbekistan. Mục tiêu của đội là lọt vào vòng 2, sau đó tranh vé dự World Cup.</p>', 'Đội tuyển bóng đá Việt Nam chuẩn bị cho World Cup 2026', 'Hà Ngoại F', '2026-04-23 13:30:00', 2100),
(7, 1, 'Hội thảo quốc tế về phát triển bền vững tại Việt Nam', 'hoi-thao-phat-trien-ben-vung', '/img/news-800x500-3.jpg', '<p>Từ 28-30/4, Hà Nội sẽ tổ chức Hội thảo quốc tế về Phát triển bền vững 2026. Sự kiện quy tụ trên 500 đại biểu từ 50 quốc gia, gồm các nhà khoa học, chính sách gia, doanh nhân.</p><p>Các chủ đề thảo luận bao gồm: Biến đổi khí hậu, kinh tế xanh, công nghệ sạch, và bảo vệ đa dạng sinh học. Đây là cơ hội tốt để Việt Nam chia sẻ kinh nghiệm và học hỏi từ các nước khác.</p>', 'Hội thảo quốc tế về phát triển bền vững diễn ra tại Hà Nội', 'Kỳ Anh G', '2026-04-22 08:15:00', 650),
(8, 2, 'Vietcombank báo lãi quý 1 năm 2026 tăng mạnh', 'vietcombank-lai-quy-1-2026', '/img/news-700x435-5.jpg', '<p>Vietcombank vừa công bố kết quả kinh doanh quý 1/2026: tổng lợi nhuận trước thuế đạt 3.245 tỷ đồng, tăng 15% so với quý 1/2025. Tổng tài sản của ngân hàng đạt 1.850 tỷ đồng.</p><p>Chất lượng cho vay được cải thiện, nợ xấu giảm xuống 0.9%. Ban lãnh đạo nhận định, triển vọng hoạt động trong nửa còn lại của năm 2026 tiếp tục sáng sủa.</p>', 'Vietcombank báo lãi quý 1 tăng 15% lên 3.245 tỷ đồng', 'Minh Hiếu H', '2026-04-21 10:45:00', 1567),
(9, 3, 'Ứng dụng AI giúp chẩn đoán ung thư sớm', 'ai-chan-doan-ung-thu', '/img/news-800x500-2.jpg', '<p>Các nhà khoa học tại Bệnh viện Bạch Mai vừa phát triển thành công ứng dụng AI có khả năng phát hiện ung thư ở giai đoạn sớm với độ chính xác 96%.</p><p>Ứng dụng này dựa trên mạng neural nhân tạo, được huấn luyện trên 50.000 bức ảnh quét CT. Bệnh viện kế hoạch triển khai rộng rãi ứng dụng này từ tháng 6/2026 tại các bệnh viện trên toàn quốc.</p>', 'Ứng dụng AI chẩn đoán ung thư sớm với độ chính xác 96%', 'Lâm Y I', '2026-04-20 14:20:00', 1823),
(10, 4, 'Blockchain Việt Nam bước vào giai đoạn phát triển chính thức', 'blockchain-viet-nam-phat-trien', '/img/news-700x435-2.jpg', '<p>Hiệp hội Blockchain Việt Nam tuyên bố, ngành công nghệ blockchain ở nước ta bước vào giai đoạn phát triển chính thức với hơn 200 công ty khởi nghiệp hoạt động trong lĩnh vực này.</p><p>Các dự án nổi bật bao gồm hệ thống thanh toán blockchain, quản lý chuỗi cung ứng, và các ứng dụng Web3. Chính phủ cũng hỗ trợ việc phát triển công nghệ này thông qua các chính sách khuyến khích.</p>', 'Blockchain Việt Nam phát triển mạnh mẽ với 200+ startup', 'Huy Hoàng J', '2026-04-19 11:30:00', 1345),
(11, 5, 'Chương trình học bổng du học Hàn Quốc 2026 mở đơn', 'hoc-bong-du-hoc-han-quoc', '/img/news-700x435-3.jpg', '<p>Bộ Giáo dục và Đào tạo thông báo mở đơn cho chương trình học bổng du học Hàn Quốc năm 2026. Chương trình cung cấp các học bổng toàn phần cho bậc đại học và sau đại học.</p><p>Người dự tuyển phải có trình độ tiếng Anh tối thiểu IELTS 5.5, GPA từ 3.0 trở lên. Hạn đăng ký dự tuyển là 31/5/2026. Liên hệ Phòng Giáo dục Quốc tế để biết thêm chi tiết.</p>', 'Mở đơn chương trình học bổng du học Hàn Quốc 2026', 'Thanh Hương K', '2026-04-18 09:00:00', 987),
(12, 6, 'Bóng rổ Việt Nam chiến thắng tại Giải vô địch châu Á', 'bong-ro-viet-nam-vo-dich-chau-a', '/img/news-700x435-5.jpg', '<p>Đội tuyển bóng rổ Việt Nam vừa giành chiến thắng 78-75 trước Thái Lan ở trận chung kết Giải vô địch Bóng rổ Châu Á 2026. Đây là lần thứ 2 trong lịch sử đội vô địch giải này.</p><p>Tiền đạo Hoàng Anh Tuấn ghi 28 điểm, được bình chọn là cầu thủ xuất sắc nhất trận. Huấn luyện viên Phil Jackson đánh giá cao tinh thần chiến đấu và sự hợp tác của các cầu thủ.</p>', 'Bóng rổ Việt Nam vô địch châu Á với chiến thắng 78-75', 'Quốc Hùng L', '2026-04-17 15:45:00', 2876);

--
-- Chỉ mục cho bảng `articles`
--
ALTER TABLE `articles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `category_id` (`category_id`);

--
-- Chỉ mục cho bảng `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `articles`
--
ALTER TABLE `articles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- ============================================================
-- Các ràng buộc cho các bảng đã đổ
-- ============================================================

--
-- Các ràng buộc cho bảng `articles`
-- FOREIGN KEY: Mối quan hệ giữa articles.category_id và categories.id
-- ON DELETE CASCADE: Nếu xóa category, tất cả articles của category đó cũng bị xóa
-- Kiến thức: Đảm bảo tính toàn vẹn dữ liệu (Data Integrity)
--
ALTER TABLE `articles`
  ADD CONSTRAINT `articles_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);

-- ============================================================
-- KẾT THÚC TRANSACTION
-- ============================================================
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

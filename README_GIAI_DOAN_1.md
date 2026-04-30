# 📰 Newsfeed - Do Án Node.js Nhóm 5

## 🎯 Mục đích
Xây dựng website tin tức với Node.js, Express.js, EJS template engine, và MySQL database.

## ✨ Tính năng
- ✅ Giao diện responsive (mobile-friendly)
- ✅ Hiển thị bài viết mới nhất
- ✅ Hiển thị bài viết xem nhiều nhất
- ✅ Phân loại bài viết theo danh mục
- ✅ Bootstrap 4.5 + Font Awesome 5 + Owl Carousel
- ✅ Database MySQL tích hợp đầy đủ

---

## 🚀 Hướng dẫn Setup

### **Bước 1: Yêu cầu hệ thống**
Trước khi bắt đầu, hãy chắc chắn bạn đã cài đặt:
- **Node.js** v14+ (Tải từ https://nodejs.org/)
- **MySQL** hoặc **MariaDB** (Tải từ https://www.mysql.com/)
- **Git** (để clone repo)

### **Bước 2: Clone Repository**
```bash
git clone https://github.com/ApocBruh/nhom-5.git
cd nhom-5
```

### **Bước 3: Cài đặt Dependencies**
```bash
npm install
```
**Lệnh này sẽ:**
- Tải toàn bộ node_modules
- Cài đặt các package từ package.json:
  - express (web framework)
  - ejs (template engine)
  - dotenv (biến môi trường)
  - mysql2 (kết nối database)
  - nodemon (auto-reload)

### **Bước 4: Cấu hình Database**

#### **Cách 4a: Tự động (Khuyên dùng - Chỉ 1 lệnh)**
```bash
npm run seed
```

**Lệnh này sẽ:**
1. ✅ Tạo database `doan_nodejs_nhom5`
2. ✅ Tạo 2 bảng: `categories`, `articles`
3. ✅ Chèn dữ liệu mẫu (6 danh mục + 12 bài viết)
4. ✅ Thiết lập các ràng buộc (Foreign Keys)

Nếu thành công, bạn sẽ thấy:
```
✅ Kết nối đến MySQL thành công!
✅ Đọc file SQL thành công!
✅ Thực thi SQL thành công!
✅ Database doan_nodejs_nhom5 đã được khởi tạo!
✅ Dữ liệu mẫu đã được chèn vào!
```

#### **Cách 4b: Manual (Nếu seed không hoạt động)**
1. Mở **phpMyAdmin** hoặc **MySQL Workbench**
2. Tạo database mới: `doan_nodejs_nhom5`
3. Import file SQL:
   - Menu: `Import`
   - Chọn file: `database/doan_nodejs_nhom5.sql`
   - Click `Go`

#### **Cách 4c: Terminal Command (Linux/Mac)**
```bash
mysql -u root -p < database/doan_nodejs_nhom5.sql
```
(Nhập password MySQL khi được yêu cầu)

### **Bước 5: Khởi động Server**
```bash
npm start
```

Hoặc nếu muốn auto-reload khi có thay đổi file:
```bash
npm run dev
```

**Output:**
```
Server đang chạy tại http://localhost:3000
```

### **Bước 6: Truy cập Website**
Mở trình duyệt web và vào:
```
http://localhost:3000
```

---

## 📁 Cấu trúc Thư mục

```
nhom-5/
├── app.js                      ← File chính (Express config)
├── package.json                ← Dependencies
├── .env                        ← Cấu hình database (không commit)
├── .env.example                ← Mẫu .env
├── README.md                   ← File này
│
├── database/
│   └── doan_nodejs_nhom5.sql   ← Toàn bộ schema + dữ liệu
│
├── scripts/
│   └── seed.js                 ← Script khởi tạo database
│
├── config/
│   └── database.js             ← Cấu hình kết nối MySQL (Giai đoạn 2)
│
├── models/                      ← Business logic (Giai đoạn 3)
│   ├── Article.js
│   └── Category.js
│
├── controllers/                 ← Xử lý requests (Giai đoạn 4)
│   └── homeController.js
│
├── routes/                      ← Định nghĩa endpoints
│   └── index.js
│
├── views/                       ← EJS templates
│   └── index.ejs
│
├── partials/                    ← EJS reusable components
│   ├── head.ejs
│   ├── header.ejs
│   └── footer.ejs
│
├── public/                      ← Static files
│   ├── css/
│   ├── js/
│   ├── img/
│   └── lib/
│
└── free-news-website-template/ ← Template gốc (reference)
```

---

## 🔧 Cấu hình .env

Mở file `.env` và điều chỉnh nếu cần:

```env
# Database
DB_HOST=localhost              # Địa chỉ MySQL (localhost = máy hiện tại)
DB_PORT=3306                   # Port MySQL (mặc định: 3306)
DB_USER=root                   # Username MySQL
DB_PASSWORD=                   # Password (để trống nếu không set)
DB_NAME=doan_nodejs_nhom5      # Tên database

# Application
PORT=3000                      # Port Node.js server
NODE_ENV=development           # Môi trường (development/production)
```

**⚠️ Lưu ý bảo mật:**
- ❌ KHÔNG commit file `.env` lên GitHub
- ✅ Thêm `.env` vào `.gitignore`
- ✅ Sử dụng `.env.example` để mẫu cấu hình

---

## 📊 Cấu trúc Database

### **Bảng `categories` (Danh mục)**
```sql
id          INT         PRIMARY KEY AUTO_INCREMENT
name        VARCHAR(100) Tên danh mục
slug        VARCHAR(100) URL-friendly name
description TEXT        Mô tả danh mục
```

**Ví dụ dữ liệu:**
| id | name | slug | description |
|----|------|------|-------------|
| 1 | Chính Trị | chinh-tri | Tin tức chính trị |
| 2 | Kinh Doanh | kinh-doanh | Tin tức kinh tế |
| 3 | Sức Khỏe | suc-khoe | Tin tức y tế |

### **Bảng `articles` (Bài viết)**
```sql
id              INT         PRIMARY KEY AUTO_INCREMENT
category_id     INT         FOREIGN KEY → categories.id
title           VARCHAR(255) Tiêu đề bài viết
slug            VARCHAR(255) URL-friendly title
thumbnail       VARCHAR(255) Đường dẫn hình ảnh
content         TEXT        Nội dung đầy đủ (HTML)
summary         TEXT        Tóm tắt bài viết
author          VARCHAR(100) Tên tác giả
published_date  DATETIME    Ngày đăng bài
views           INT         Số lượt xem
```

---

## 🐛 Xử lý Lỗi

### **Lỗi: "Cannot find module 'mysql2'"**
```bash
npm install mysql2
```

### **Lỗi: "Access denied for user 'root'@'localhost'"**
- Kiểm tra password trong `.env`
- Đảm bảo MySQL đang chạy
- Đổi `DB_USER` thành user khác nếu cần

### **Lỗi: "Database does not exist"**
- Chạy lệnh: `npm run seed`
- Hoặc import SQL file thủ công

### **Lỗi: "MySQL server is not running"**
- Windows: Khởi động MySQL từ Services
- Mac: `brew services start mysql`
- Linux: `sudo service mysql start`

---

## 📚 Công nghệ Sử dụng

| Công nghệ | Phiên bản | Mục đích |
|-----------|----------|---------|
| Node.js | 14+ | Runtime JavaScript server-side |
| Express.js | 5.2.1 | Web framework |
| EJS | 5.0.2 | Template engine |
| MySQL2 | 3.6.5 | Database driver |
| dotenv | 17.4.2 | Biến môi trường |
| Bootstrap | 4.5.3 | CSS framework |
| Owl Carousel | 2.2.1 | Slider/Carousel |
| Font Awesome | 5.15.0 | Icon library |

---

## 📋 Danh Sách Giai Đoạn Thực Hiện

- [x] **Giai đoạn 1:** Thiết kế CSDL ✅
  - ✅ Tạo file SQL
  - ✅ Tạo script seed
  - ✅ Cấu hình .env
  
- [ ] **Giai đoạn 2:** Cấu hình kết nối DB
- [ ] **Giai đoạn 3:** Tạo Models
- [ ] **Giai đoạn 4:** Cập nhật Routes
- [ ] **Giai đoạn 5:** Cập nhật View
- [ ] **Giai đoạn 6:** Tạo dữ liệu mẫu

---

## 👥 Thông tin Nhóm

**Nhóm 5 - Do Án Node.js**
- Giảng viên hướng dẫn: [Tên GV]
- Năm học: 2025-2026
- Lớp: [Tên lớp]

---

## 📝 Ghi Chú

- Tất cả bình luận code đều bằng **Tiếng Việt** để dễ hiểu
- Sử dụng **Promise-based** (async/await) thay vì callbacks
- Áp dụng **MVC Pattern** để tổ chức code sạch
- Database sử dụng **utf8mb4_vietnamese_ci** để hỗ trợ tiếng Việt

---

## 📞 Hỗ Trợ

Nếu gặp vấn đề:
1. Kiểm tra lại các bước setup
2. Xem file `.env` có đúng không
3. Chắc chắn MySQL đang chạy
4. Xem console output để tìm lỗi chi tiết

---

**Chúc bạn thành công! 🎉**

const express = require('express');
const path = require('path');
require('dotenv').config();

const app = express();
const port = process.env.PORT || 3000;

// Cấu hình EJS
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'src', 'views'));

// Cấu hình thư mục tĩnh (css, js, img)
app.use(express.static(path.join(__dirname, 'src', 'public')));

// Route trang chủ cơ bản
app.get('/', (req, res) => {
    // BƯỚC 1 (Giả lập): Lấy dữ liệu cấu hình Website từ CSDL
    // Sau này khi kết nối DB, bạn sẽ select bảng "CauHinh" hoặc "WebsiteInfo"
    const mockSiteInfo = {
        address: "123 Đường Công Nghệ, Quận 1, TP.HCM",
        email: "contact@newsfeed.com",
        facebook: "https://facebook.com/nhom5newsfeed",
        youtube: "https://youtube.com/nhom5newsfeed",
        copyright: "© 2023 Nhom 5 - Do An Node.js. All rights reserved."
    };

    // BƯỚC 2: Truyền dữ liệu ra View (index.ejs)
    res.render('index', { 
        title: 'Trang chủ - Newsfeed',
        siteInfo: mockSiteInfo 
    });
});

app.listen(port, () => {
    console.log(`Server đang chạy tại http://localhost:${port}`);
});

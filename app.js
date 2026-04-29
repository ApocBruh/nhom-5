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
    res.render('index', { title: 'Trang chủ - Newsfeed' });
});

app.listen(port, () => {
    console.log(`Server đang chạy tại http://localhost:${port}`);
});

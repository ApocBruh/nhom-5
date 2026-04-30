/**
 * ============================================================
 * FILE: scripts/seed.js
 * MỤC ĐÍCH: Tự động khởi tạo database từ file SQL
 * CÁCH SỬ DỤNG: npm run seed
 * ============================================================
 * 
 * File này làm những công việc sau:
 * 1. Kết nối đến MySQL server
 * 2. Đọc file database/doan_nodejs_nhom5.sql
 * 3. Thực thi toàn bộ SQL queries trong file
 * 4. In ra thông báo kết quả (thành công hoặc lỗi)
 * 
 * Lợi ích:
 * - Tự động hóa quá trình setup database
 * - Giảng viên chỉ cần chạy: npm run seed
 * - Không cần phải import SQL manually vào phpMyAdmin
 * - Đảm bảo tất cả các schema và dữ liệu được tạo đúng
 */

// ============================================================
// BƯỚC 1: IMPORT CÁC DEPENDENCIES
// ============================================================

// mysql2/promise: Thư viện MySQL với Promise hỗ trợ (async/await)
// Khác với callback-based mysql2/mysql
// Ưu điểm: Code sạch hơn, dễ đọc, xử lý lỗi dễ dàng hơn
const mysql = require('mysql2/promise');

// fs: File System module - đọc file từ ổ cứng
// readFileSync: Đọc file đồng bộ (chờ cho đến khi đọc xong)
const fs = require('fs');

// path: Module xử lý đường dẫn file/folder
// join: Ghép các phần đường dẫn thành đường dẫn hoàn chỉnh
// Ví dụ: path.join(__dirname, '../database/...') = /home/user/nhom-5/database/...
const path = require('path');

// dotenv: Load biến môi trường từ file .env
// Giúp bảo mật thông tin nhạy cảm (host, user, password)
require('dotenv').config();

// ============================================================
// BƯỚC 2: HÀM CHÍNH - SEED DATABASE
// ============================================================

/**
 * Hàm async main() để khởi tạo database
 * 
 * Workflow:
 * 1. Tạo connection đến MySQL (root, không database)
 * 2. Đọc file doan_nodejs_nhom5.sql
 * 3. Tách SQL queries bằng dấu ";"
 * 4. Thực thi từng query
 * 5. In ra kết quả
 * 6. Đóng connection
 */
async function seedDatabase() {
  let connection;
  
  try {
    // ============================================================
    // BƯỚC 3: TẠO CONNECTION ĐẾN MYSQL
    // ============================================================
    
    // process.env.DB_HOST: Lấy giá trị từ .env (mặc định: localhost)
    // process.env.DB_USER: Lấy user từ .env (mặc định: root)
    // process.env.DB_PASSWORD: Lấy password từ .env
    // 
    // Lưu ý: Không chỉ định 'database' vì database chưa tồn tại
    // Database sẽ được tạo bởi query "CREATE DATABASE IF NOT EXISTS"
    connection = await mysql.createConnection({
      host: process.env.DB_HOST || 'localhost',
      user: process.env.DB_USER || 'root',
      password: process.env.DB_PASSWORD || '',
      multipleStatements: true  // Cho phép thực thi nhiều SQL statements
    });
    
    console.log('✅ Kết nối đến MySQL thành công!');
    
    // ============================================================
    // BƯỚC 4: ĐỌC FILE SQL
    // ============================================================
    
    // __dirname: Đường dẫn của thư mục chứa file script này
    // path.join(__dirname, '../database/...'): Ghép thành đường dẫn đầy đủ
    // readFileSync: Đọc file đồng bộ (chờ đến khi đọc xong)
    // 'utf8': Encoding (UTF-8 hỗ trợ tiếng Việt, emoji, v.v.)
    const sqlFilePath = path.join(__dirname, '../database/doan_nodejs_nhom5.sql');
    const sqlContent = fs.readFileSync(sqlFilePath, 'utf8');
    
    console.log('✅ Đọc file SQL thành công!');
    
    // ============================================================
    // BƯỚC 5: THỰC THI QUERIES
    // ============================================================
    
    // query(): Thực thi SQL commands
    // multipleStatements: true cho phép chạy nhiều statement cùng lúc
    // await: Chờ query hoàn thành (promise-based)
    await connection.query(sqlContent);
    
    console.log('✅ Thực thi SQL thành công!');
    console.log('✅ Database doan_nodejs_nhom5 đã được khởi tạo!');
    console.log('✅ Bảng categories và articles đã được tạo!');
    console.log('✅ Dữ liệu mẫu đã được chèn vào!');
    
  } catch (error) {
    // ============================================================
    // XỬ LÝ LỖI
    // ============================================================
    
    console.error('❌ Lỗi khi khởi tạo database:');
    console.error(error.message);
    
    // Nếu lỗi là "Access denied", gợi ý kiểm tra cấu hình .env
    if (error.code === 'ER_ACCESS_DENIED_FOR_USER') {
      console.error('\n💡 Gợi ý: Kiểm tra lại thông tin database trong file .env');
      console.error('   - DB_HOST: Địa chỉ MySQL server (mặc định: localhost)');
      console.error('   - DB_USER: Tên user (mặc định: root)');
      console.error('   - DB_PASSWORD: Mật khẩu');
    }
    
    // Nếu lỗi là "Cannot read property 'command' of null", có thể MySQL chưa start
    if (error.code === 'PROTOCOL_CONNECTION_LOST') {
      console.error('\n💡 Gợi ý: MySQL server có thể không đang chạy');
      console.error('   - Hãy khởi động MySQL service');
    }
    
    process.exit(1);  // Thoát với mã lỗi 1
  } finally {
    // ============================================================
    // BƯỚC 6: ĐÓ NGỪNG CONNECTION
    // ============================================================
    
    // Luôn đóng connection (dù thành công hay lỗi)
    if (connection) {
      await connection.end();
      console.log('✅ Đóng kết nối MySQL thành công!');
    }
  }
}

// ============================================================
// BƯỚC 7: GỌI HÀM CHÍNH
// ============================================================

seedDatabase()
  .catch(error => {
    console.error('❌ Lỗi không được xử lý:', error);
    process.exit(1);
  });

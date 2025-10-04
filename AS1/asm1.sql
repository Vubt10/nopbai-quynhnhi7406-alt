-- 1. Tạo cơ sở dữ liệu
CREATE DATABASE QLNHATRO_NhiNNQ;
GO
USE QLNHATRO_NhiNNQ;
GO


-- 2. Bảng LOAINHA: lưu loại hình nhà trọ (Căn hộ, Nhà riêng, Phòng trọ,...)
CREATE TABLE LOAINHA (
    MaLoai CHAR(5) PRIMARY KEY,
    TenLoai NVARCHAR(100) NOT NULL,
    MoTa NVARCHAR(255)
);
GO

-- 3. Bảng NGUOIDUNG: lưu thông tin người dùng website
CREATE TABLE NGUOIDUNG (
    MaNguoiDung CHAR(5) PRIMARY KEY,
    HoTen NVARCHAR(100) NOT NULL,
    GioiTinh NVARCHAR(3) CHECK (GioiTinh IN (N'Nam', N'Nữ', N'Khác')),
    DienThoai VARCHAR(15) NOT NULL,
    SoNha NVARCHAR(50),
    TenDuong NVARCHAR(100),
    Phuong NVARCHAR(100),
    Quan NVARCHAR(100),
    Email NVARCHAR(100) NOT NULL UNIQUE
);
GO

-- 4. Bảng NHATRO: lưu thông tin nhà trọ cho thuê
CREATE TABLE NHATRO (
    MaNhaTro CHAR(5) PRIMARY KEY,
    MaLoai CHAR(5) NOT NULL,
    DienTich FLOAT CHECK (DienTich > 0),
    GiaPhong DECIMAL(12,2) CHECK (GiaPhong > 0),
    SoNha NVARCHAR(50),
    TenDuong NVARCHAR(100),
    Phuong NVARCHAR(100),
    Quan NVARCHAR(100),
    MoTa NVARCHAR(255),
    NgayDang DATE DEFAULT GETDATE(),
    MaNguoiLienHe CHAR(5) NOT NULL,
    FOREIGN KEY (MaLoai) REFERENCES LOAINHA(MaLoai),
    FOREIGN KEY (MaNguoiLienHe) REFERENCES NGUOIDUNG(MaNguoiDung)
);
GO

-- 5. Bảng DANHGIA: lưu đánh giá của người dùng
CREATE TABLE DANHGIA (
    MaDanhGia INT IDENTITY(1,1) PRIMARY KEY,
    MaNguoiDung CHAR(5) NOT NULL,
    MaNhaTro CHAR(5) NOT NULL,
    Thich BIT NOT NULL,   -- 1 = LIKE, 0 = DISLIKE
    NoiDung NVARCHAR(255),
    NgayDanhGia DATE DEFAULT GETDATE(),
    FOREIGN KEY (MaNguoiDung) REFERENCES NGUOIDUNG(MaNguoiDung),
    FOREIGN KEY (MaNhaTro) REFERENCES NHATRO(MaNhaTro)
);
GO

 INSERT INTO LOAINHA VALUES
('L001', N'Căn hộ chung cư', N'Thiết kế hiện đại, đầy đủ tiện nghi'),
('L002', N'Nhà riêng', N'Phù hợp cho gia đình nhỏ'),
('L003', N'Phòng trọ khép kín', N'Giá rẻ, tiện lợi cho sinh viên');

INSERT INTO NGUOIDUNG VALUES
('ND001', N'Nguyễn Hoàng Long', N'Nam', '0909123456', N'12', N'Lê Lợi', N'Phường 1', N'Quận 3', 'long@gmail.com'),
('ND002', N'Lê Minh Anh', N'Nữ', '0912345678', N'25', N'Cách Mạng Tháng 8', N'Phường 10', N'Quận 10', 'anhle@gmail.com'),
('ND003', N'Trần Hữu Phước', N'Nam', '0988777666', N'56', N'Nguyễn Trãi', N'Phường 7', N'Quận 5', 'phuoc@gmail.com'),
('ND004', N'Vũ Thị Mai', N'Nữ', '0908111222', N'78', N'Điện Biên Phủ', N'Phường 15', N'Bình Thạnh', 'mai@gmail.com'),
('ND005', N'Lâm Quốc Huy', N'Nam', '0977334455', N'99', N'Hai Bà Trưng', N'Phường 8', N'Quận 3', 'huy@gmail.com'),
('ND006', N'Nguyễn Thị Hằng', N'Nữ', '0966998877', N'45', N'Phan Xích Long', N'Phường 2', N'Phú Nhuận', 'hang@gmail.com'),
('ND007', N'Phạm Đức Thịnh', N'Nam', '0944556677', N'80', N'Trường Chinh', N'Phường 13', N'Tân Bình', 'thinh@gmail.com'),
('ND008', N'Lê Ngọc Dung', N'Nữ', '0911667788', N'34', N'Hoàng Sa', N'Phường 5', N'Quận 1', 'dung@gmail.com'),
('ND009', N'Nguyễn Minh Tuấn', N'Nam', '0909333444', N'22', N'Nguyễn Đình Chiểu', N'Phường 6', N'Quận 3', 'tuan@gmail.com'),
('ND010', N'Trần Mỹ Hạnh', N'Nữ', '0932111222', N'88', N'Nam Kỳ Khởi Nghĩa', N'Phường 7', N'Quận 3', 'hanh@gmail.com');

INSERT INTO NHATRO VALUES
('NT001', 'L001', 45, 7000000, N'12', N'Lê Lợi', N'Phường 1', N'Quận 3', N'Căn hộ đầy đủ nội thất', '2025-09-15', 'ND001'),
('NT002', 'L002', 60, 9000000, N'25', N'CMT8', N'Phường 10', N'Quận 10', N'Nhà riêng có sân để xe', '2025-09-16', 'ND002'),
('NT003', 'L003', 20, 3000000, N'56', N'Nguyễn Trãi', N'Phường 7', N'Quận 5', N'Phòng trọ gần trường đại học', '2025-09-17', 'ND003'),
('NT004', 'L003', 25, 3500000, N'78', N'Điện Biên Phủ', N'Phường 15', N'Bình Thạnh', N'Phòng mới xây sạch đẹp', '2025-09-18', 'ND004'),
('NT005', 'L002', 70, 10000000, N'99', N'Hai Bà Trưng', N'Phường 8', N'Quận 3', N'Nhà riêng 2 tầng tiện nghi', '2025-09-19', 'ND005'),
('NT006', 'L001', 50, 8000000, N'45', N'Phan Xích Long', N'Phường 2', N'Phú Nhuận', N'Căn hộ cao cấp', '2025-09-20', 'ND006'),
('NT007', 'L003', 18, 2500000, N'80', N'Trường Chinh', N'Phường 13', N'Tân Bình', N'Phòng giá rẻ', '2025-09-21', 'ND007'),
('NT008', 'L002', 65, 9500000, N'34', N'Hoàng Sa', N'Phường 5', N'Quận 1', N'Nhà riêng gần trung tâm', '2025-09-22', 'ND008'),
('NT009', 'L001', 55, 8500000, N'22', N'Nguyễn Đình Chiểu', N'Phường 6', N'Quận 3', N'Căn hộ thoáng mát', '2025-09-23', 'ND009'),
('NT010', 'L003', 22, 3200000, N'88', N'Nam Kỳ Khởi Nghĩa', N'Phường 7', N'Quận 3', N'Phòng sạch sẽ an ninh tốt', '2025-09-24', 'ND010');

INSERT INTO DANHGIA (MaNguoiDung, MaNhaTro, Thich, NoiDung)
VALUES
('ND001', 'NT003', 1, N'Phòng sạch sẽ, chủ thân thiện'),
('ND002', 'NT005', 1, N'Nhà đẹp, yên tĩnh'),
('ND003', 'NT001', 0, N'Giá hơi cao'),
('ND004', 'NT007', 1, N'Rẻ và tiện nghi'),
('ND005', 'NT006', 1, N'Căn hộ mới, hiện đại'),
('ND006', 'NT004', 0, N'Hơi xa trung tâm'),
('ND007', 'NT002', 1, N'Nhà riêng thoáng mát'),
('ND008', 'NT009', 1, N'Căn hộ phù hợp với dân văn phòng'),
('ND009', 'NT008', 0, N'Giá cao so với khu vực'),
('ND010', 'NT010', 1, N'Phòng nhỏ nhưng sạch sẽ');

select * from DANHGIA
CREATE DATABASE QL_SV2
GO

USE QL_SV2
GO

CREATE TABLE SinhVien(
	MaSV VARCHAR(20) PRIMARY KEY,
	HoTen NVARCHAR(20),
	NgaySinh DATE,
	Lop VARCHAR(20)
);

CREATE TABLE MonHoc(
	MaMH VARCHAR(20) PRIMARY KEY,
	TenMH NVARCHAR(20),
	SoTinChi INT,
	LoaiMon VARCHAR(20)
);

CREATE TABLE KetQua(
	MaSV VARCHAR(20),
	MaMH VARCHAR(20),
	Diem FLOAT,
	PRIMARY KEY(MaSV,MaMH),
	FOREIGN KEY (MaSV) REFERENCES SinhVien(MaSV),
	FOREIGN KEY (MaMH) REFERENCES MonHoc(MaMH)
);

INSERT INTO SinhVien VALUES 
('SV01', N'Nguyễn Hữu Đat', '2003-01-15', 'TINX'),
('SV02', N'Lê Oanh', '2003-05-20', 'TINX'),
('SV03', N'Hoshinaa', '2003-11-02', 'DHMT18A2HN');

INSERT INTO MonHoc VALUES 
('MH01', N'Lập trình net', 3, N'Chuyên ngành'),
('MH02', N'Tin cơ sở', 2, N'Đại cương');

INSERT INTO KetQua VALUES 
('SV01', 'MH01', 9.5),
('SV01', 'MH02', 3.5),
('SV02', 'MH02', 3.75), 
('SV03', 'MH01', 4.5);

SELECT * FROM SinhVien 
SELECT * FROM MonHoc
SELECT * FROM KetQua

--1
SELECT SV.* FROM SinhVien SV
	JOIN KetQua KQ ON KQ.MaSV = SV.MaSV
	JOIN MonHoc MH ON MH.MaMH = KQ.MaMH
	WHERE MH.TenMH = N'Lập trình net'
	AND Diem >= 9
GO

--2
SELECT MH.TenMH,COUNT(KQ.MaSV) AS SoSinhVienTruot FROM MonHoc MH
	JOIN KetQua KQ ON KQ.MaMH = MH.MaMH
	WHERE KQ.Diem < 5
	GROUP BY MH.TenMH
GO

--3
UPDATE KetQua
	SET Diem = Diem + 0.25
	FROM KetQua KQ
	JOIN MonHoc MH ON MH.MaMH = KQ.MaMH
	WHERE MH.TenMH = N'Tin cơ sở' AND KQ.Diem < 4
GO

--4
DELETE KQ FROM KetQua KQ
	JOIN SinhVien SV ON SV.MaSV = KQ.MaSV
	WHERE SV.Lop = N'TINX'
GO

--5
CREATE VIEW Thongtin AS
	SELECT SV.MaSV,SV.HoTen,MH.TenMH,MH.SoTinChi,KQ.Diem FROM SinhVien SV
	JOIN KetQua KQ ON KQ.MaSV = SV.MaSV
	JOIN MonHoc MH ON MH.MaMH = KQ.MaMH
GO

SELECT * FROM Thongtin
GO

--Cau 2
CREATE DATABASE QL_Kho
GO

USE QL_Kho
GO

CREATE TABLE Kho(
	MaKho VARCHAR(20) PRIMARY KEY,
	TenKho NVARCHAR(20),
	ViTri NVARCHAR(20),
	SucChua INT
);

CREATE TABLE HangHoa(
	MaHang VARCHAR(20) PRIMARY KEY,
	TenHang NVARCHAR(20),
	SoLuong INT,
	LoaiHang NVARCHAR(20)
);

CREATE TABLE HangNhap(
	MaKho VARCHAR(20),
	MaHang VARCHAR(20),
	NgayNhap DATE,
	SLNhap INT,
	PRIMARY KEY (MaKho,MaHang),
	FOREIGN KEY (MaKho) REFERENCES Kho(MaKho),
	FOREIGN KEY (MaHang) REFERENCES HangHoa(MaHang)
);

INSERT INTO Kho VALUES 
('K01', N'Kho Tổng', N'Khu vực B1', 1000),
('K02', N'Kho Phụ 1', N'Khu vực B1', 500),
('K03', N'Kho Vật Liệu', N'Khu vực B2', 2000),
('K04', N'Kho Dự Phòng', N'Khu vực B3', 300);

INSERT INTO HangHoa VALUES 
('H01', N'Fe 16', 150, N'Kim loại'),
('H02', N'Xi măng PC40', 500, N'Vật liệu xây dựng'),
('H03', N'Gạch men', 1000, N'Hoàn thiện'),
('H04', N'Sơn nước', 200, N'Hóa chất');

INSERT INTO HangNhap VALUES 
('K01', 'H01', '2023-10-01', 100),
('K02', 'H01', '2023-10-15', 120),
('K01', 'H02', '2023-11-05', 80),  
('K03', 'H02', '2023-11-10', 90),
('K03', 'H03', '2023-12-01', 300);

SELECT * FROM Kho
SELECT * FROM HangHoa
SELECT * FROM HangNhap

--1
SELECT * FROM Kho 
	WHERE ViTri = N'Khu vực B1';

--2
SELECT HH.TenHang,AVG(HN.SLNhap) AS TrungBinh FROM HangNhap HN
	JOIN HangHoa HH ON HH.MaHang = HN.MaHang
	GROUP BY HH.TenHang
	HAVING AVG(HN.SLNhap) >= 95;

--3
UPDATE HangHoa 
	SET TenHang = N'Sắt 16'
	WHERE TenHang = N'Fe 16';

--4
DELETE K FROM KHO K
	WHERE NOT EXISTS(
		SELECT 1 FROM HangNhap HN
		WHERE HN.MaKho = K.MaKho
);

--5
CREATE VIEW NhapHang AS
	SELECT K.MaKho,K.TenKho,HH.TenHang,HN.SLNhap FROM Kho K
	JOIN HangNhap HN ON HN.MaKho = K.MaKho
	JOIN HangHoa HH ON HH.MaHang = HN.MaHang;

SELECT * FROM NhapHang



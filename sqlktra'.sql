CREATE DATABASE QL_BanHang

CREATE TABLE NCC(
	MaNCC VARCHAR(15) PRIMARY KEY,
	TenNCC NVARCHAR(15),
	Tinhtrang NVARCHAR(15),
	NoiSX NVARCHAR(15)
);

CREATE TABLE MH(
	MaMH VARCHAR(15) PRIMARY KEY,
	TenMH NVARCHAR(15),
	Mau NVARCHAR(15),
	Khoiluong INT,
	NoiSX NVARCHAR(15)
);

CREATE TABLE NM(
	MaNCC VARCHAR(15),
	MaMH VARCHAR(15),
	Soluong INT,
	PRIMARY KEY(MaNCC,MaMH),
	FOREIGN KEY (MaNCC) REFERENCES NCC(MaNCC),
	FOREIGN KEY (MaMH) REFERENCES MH(MaMH)
);

INSERT INTO NCC 
	VALUES ('NCC01','Acer','Bình thường','Hà Nội'),
			('NCC02','Dell','Bình Thường','Hưng Yên'),
			('NCC03','HP','Hồng','Bắc Ninh'),
			('NCC04','Samsung','Hồng','Bắc Ninh');

INSERT INTO MH	
	VALUES ('MH01','Tivi LCD','Đen',20,'Bắc Ninh'),
			('MH02','Laptop','Đen',14,'Bắc Ninh'),
			('MH03','HDD','Trắng',42,'Hưng Yên'),
			('MH04','Screen','Đen',16,'Hà Nội');

INSERT INTO NM
	VALUES ('NCC01','MH01',15),
			('NCC01','MH02',10),
			('NCC02','MH01',24),
			('NCC03','MH04',12);

SELECT * FROM NCC;
SELECT * FROM MH;
SELECT * FROM NM;

--Cau 2:
	--2.1
SELECT * FROM MH
	WHERE Mau = 'Đen';

	--2.2
SELECT * FROM MH
	WHERE Khoiluong = (
		SELECT MAX(Khoiluong)
		FROM MH
);


SELECT MaMH, MAX(Soluong) AS SoLuongMax
FROM NM
GROUP BY MaMH;

CREATE VIEW TK AS
SELECT 
    NCC.MaNCC, 
    NCC.TenNCC, 
    SUM(NM.Soluong) AS TongSoLuong
FROM NCC 
JOIN NM ON NCC.MaNCC = NM.MaNCC
GROUP BY NCC.MaNCC, NCC.TenNCC;

SELECT * FROM TK;
	
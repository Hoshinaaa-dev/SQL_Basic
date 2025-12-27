--Cau 1
CREATE DATABASE QL_ca_si
GO

USE Ql_ca_si
GO

CREATE TABLE CaSi(
	Macs VARCHAR(15) PRIMARY KEY,
	hoten NVARCHAR(20),
	ngaysinh DATE,
	quequan NVARCHAR(20)
);

CREATE TABLE BaiHat(
	Mabh VARCHAR(20) PRIMARY KEY,
	tenbh NVARCHAR(15),
	namsangtac INT,
	NSsangtac NVARCHAR(20),
	theloai NVARCHAR(15)
);

CREATE TABLE TrinhBay(
	Macs VARCHAR(15),
	Mabh VARCHAR(20),
	ngaytrinhbay DATE
	PRIMARY KEY(Macs,Mabh),
	FOREIGN KEY (Macs) REFERENCES CaSi(Macs),
	FOREIGN KEY (Mabh) REFERENCES BaiHat(Mabh)
);


INSERT INTO BaiHat
	VALUES('BH01',N'Mùa hoa',1987,N'Lê An',N'Nhạc trẻ'),
			('BH02',N'Mẹ tôi',2010,N'Hà Thu',N'Nhạc trẻ'),
			('BH03',N'Có khi',2012,N'Hoài Lâm',N'Nhạc trẻ')
GO


INSERT INTO CaSi
	VALUES('CS01',N'Khởi My','1990-01-01',N'Đồng Nai'),
			('CS02',N'Khắc Việt','1987-08-30',N'Hà Thu'),
			('CS03',N'Có khi','2015-04-05',N'Hoài Lâm')
GO

INSERT INTO TrinhBay
	VALUES('CS01','BH01','2016-02-03'),
			('CS02','BH02','2015-03-03'),
			('CS03','BH03','2015-04-05')
GO

SELECT * FROM BaiHat
SELECT * FROM CaSi
SELECT * FROM TrinhBay

ALTER TABLE CaSi
	ADD Nghedanh NVARCHAR(20) 


--6

SELECT BH.* FROM BaiHat BH
	JOIN TrinhBay TB ON TB.Mabh = BH.Mabh
	JOIN CaSi CS ON CS.Macs = TB.Macs
	WHERE CS.Hoten = N'Khởi My'
	AND TB.ngaytrinhbay = '2016-02-03'
	AND BH.tenbh = N'Cỏ úa'

--Trong du lieu khong co bai Co ua 
SELECT BH.* FROM BaiHat BH
	JOIN TrinhBay TB ON TB.Mabh = BH.Mabh
	JOIN CaSi CS ON CS.Macs = TB.Macs
	WHERE CS.Hoten = N'Khởi My'
	AND TB.ngaytrinhbay = '2016-02-03'
	AND BH.tenbh = N'Mùa hoa'

--7
SELECT COUNT(*) AS TongSoBai FROM BaiHat

--8
SELECT CS.Macs,COUNT(TB.ngaytrinhbay) AS TongBaiHat FROM CaSi CS
	JOIN TrinhBay TB ON TB.Macs = CS.Macs
	GROUP BY CS.Macs
	HAVING COUNT(TB.ngaytrinhbay) >= 1
	ORDER BY TongBaiHat DESC 

--Cau 2

CREATE DATABASE QLcasi
GO

USE QLcasi
GO

CREATE TABLE CaSi2(
	MaCaSi2 VARCHAR(10) PRIMARY KEY,
	hoten2 NVARCHAR(20),
	ngaysinh2 DATE,
	quequan2 NVARCHAR(20)
)

CREATE TABLE BaiHat2(
	Mabh2 VARCHAR(10) PRIMARY KEY,
	tenbh2 NVARCHAR(20),
	namsangtac2 INT,
	tacgia2 NVARCHAR(20),
	theloai2 NVARCHAR(10)
)

CREATE TABLE TrinhBay2(
	MaCaSi2 VARCHAR(10),
	Mabh2 VARCHAR(10),
	ngaytrinhbay2 DATE,
	PRIMARY KEY(MaCaSi2,Mabh2),
	FOREIGN KEY (MaCaSi2) REFERENCES CaSi2(MaCaSi2),
	FOREIGN KEY (Mabh2) REFERENCES BaiHat2(Mabh2)
)

SELECT * FROM BaiHat2
	ORDER BY namsangtac2 ASC;

SELECT * FROM BaiHat2
	WHERE theloai2 = N'Nhạc trẻ'

SELECT TB.MaCaSi2,COUNT(BH.Mabh2) AS TongSoBaiHat FROM BaiHat2 BH
	JOIN TrinhBay2 TB ON TB.Mabh2 = BH.Mabh2
	WHERE TB.Mabh2 = N'CS02'
	GROUP BY TB.MaCaSi2

SELECT BH.* FROM BaiHat2 BH
	JOIN TrinhBay2 TB ON TB.Mabh2 = BH.Mabh2
	WHERE TB.ngaytrinhbay2 = '2024-11-20'
	
CREATE VIEW THONGKE AS 
	SELECT BH.tenbh2,BH.namsangtac2,BH.tacgia2,BH.theloai2 FROM BaiHat2 BH
	JOIN TrinhBay2 TB ON TB.Mabh2 = BH.Mabh2
	JOIN CaSi2 CS ON CS.MaCaSi2 = TB.MaCaSi2
	WHERE CS.hoten2 = N'Hoài Lâm'

SELECT * FROM THONGKE
GO
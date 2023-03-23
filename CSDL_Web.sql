--Tạo database có tên VJIT:
create database DoAnweb
on --định nghĩa file .MDF (dữ liệu)
(--luận lý
	name='web_Data',
	--vật lý
	filename='D:\Database\web.MDF'
)--định nghĩa file .LDF (nhật ký)
log on
(--vật lý
	name='web_Log',
	--vật lý
	filename='D:\Database\web.LDF'
)
--Chọn DB hiện hành
use web
create table KhachHang
(
	MAKH	varchar(15) primary key,
	TENKH	nvarchar(50),
	SDT		varchar(13),
	CCCD	varchar(12),
	DiaChi	nvarchar(200)
)
create table NCC
(
	MANCC	varchar(15) primary key,
	TENNCC	nvarchar(50),
	SDT		varchar(13),
	Email	varchar(50),
	DiaChi	nvarchar(200)
)
create table NPP
(
	MANPP	varchar(15) primary key,
	TENNPP	nvarchar(50),
	SDT		varchar(13),
	Email	varchar(50),
	DiaChi	nvarchar(200)
)
create table SanPham
(
	MASP	varchar(15) primary key,
	MANCC	varchar(15),
	MaNPP	varchar(15),
	TENSP	nvarchar(50),
	AnhSP	image,
	foreign key(MANCC) references NCC(MANCC)
	on update cascade
	on delete cascade,
	foreign key(MANPP) references NPP(MANPP)
	on update cascade
	on delete cascade
)
create table ChiTietSP
(
	MaDT	varchar(15) primary key,
	MaSP	varchar(15),
	Mang	varchar(100),
	NgaySX	Datetime,
	TrangThai	varchar(50),
	Kichco	varchar(100),
	Trongluong	char(100),
	LoaiMH	varchar(50),
	SizeMH	varchar(20),
	Thenho	varchar(20),
	GPRS	varchar(20),
	Bluetooth	varchar(20),
	Hongngoai	varchar(20),
	USB	varchar(20),
	Os	varchar(50),
	Pin	varchar(50),
	Soluong	int,
	DonGia Decimal (9),
	Img	varchar (100),
	foreign key(MASP) references SanPham(MASP)
	on update cascade
	on delete cascade
)
create table GioHang
(
	MAGH	varchar(50) primary key,
	MAKH	varchar(15),
	MADT	varchar(15),
	MASP	varchar(15),
	SoLuong int,
	DonGia Decimal (9),
	ThanhTien Decimal (16)
	foreign key(MAKH) references KhachHang(MAKH)
	on update cascade
	on delete cascade,
	foreign key(MADT) references ChiTietSP(MADT)
	on update cascade
	on delete cascade,
	foreign key(MASP) references SanPham(MASP)
)
create table HoaDon
(
	MaHD	varchar(50) primary key,
	MaKH	varchar(15),
	MaSP	varchar(15),
	MaDT	varchar(15),
	SoLuong	int,
	DonGia	Decimal (9),
	TongTien	Decimal (9),	
	NgayLap	Datetime,
	DiaDiemGiao nvarchar(500),
	foreign key(MAKH) references KhachHang(MAKH)
	on update cascade
	on delete cascade,
	foreign key(MADT) references ChiTietSP(MADT)
	on update cascade
	on delete cascade,
	foreign key(MASP) references SanPham(MASP)

)
create table DanhGia
(
	MaDG varchar(15) primary key,
	MaKH varchar(15),
	TenKH nvarchar(50),
	NgayDanhGia Datetime,
	NoiDung nvarchar(1000),
	foreign key(MAKH) references KhachHang(MAKH)
	on update cascade
	on delete cascade,
)

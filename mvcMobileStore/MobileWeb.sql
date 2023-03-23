--Tạo database có tên VJIT:
create database web_doan
on --định nghĩa file .MDF (dữ liệu)
(--luận lý
	name='web_Data',
	--vật lý
	filename='D:\Database\mobileweb.MDF'
)--định nghĩa file .LDF (nhật ký)
log on
(--vật lý
	name='web_Log',
	--vật lý
	filename='D:\Database\mobileweb.LDF'
)
--Chọn DB hiện hành
use mobileweb
create table KhachHang
(
	MAKH	int identity(1,1) PRIMARY KEY,
	TENKH	nvarchar(100) NOT NULL,
	Taikhoan varchar(50) UNIQUE,
	Matkhau varchar(50) NOT NULL,
	SDT		varchar(13),
	CCCD	varchar(12),
	DiaChi	nvarchar(200),
	Ngaysinh DATETIME
)
create table NCC
(
	MANCC	varchar(15) primary key,
	TENNCC	nvarchar(150),
	SDT		varchar(13),
	Email	varchar(50),
	DiaChi	nvarchar(200)
)
create table NPP
(
	MANPP	varchar(15) primary key,
	TENNPP	nvarchar(150),
	SDT		varchar(13),
	Email	varchar(50),
	DiaChi	nvarchar(200)
)
create table SanPham
(
	MASP	int IDENTITY(1,1),
	MANCC	varchar(15),
	MaNPP	varchar(15),
	TENSP	nvarchar(150),
	GIABAN	Decimal(18,0) CHECK (Giaban>=0),
	AnhSP	varchar(150),
	Constraint PK_Sach Primary Key(MASP),
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
	MaSP	int,
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
CREATE TABLE DONDATHANG
(
	MaDonHang INT IDENTITY(1,1) primary key,
	Dathanhtoan bit,
	Tinhtranggiaohang  bit,
	Ngaydat Datetime,
	Ngaygiao Datetime,	
	MaKH INT,
	foreign key(MAKH) references KhachHang(MAKH)
	on update cascade
	on delete cascade
)
CREATE TABLE CHITIETDONTHANG
(
	MaDonHang INT,
	MaSP INT,
	Soluong Int Check(Soluong>0),
	Dongia Decimal(18,0) Check(Dongia>=0),	
	CONSTRAINT PK_CTDatHang PRIMARY KEY(MaDonHang,MaSP),
	foreign key(MASP) references SanPham(MASP)
	on update cascade
	on delete cascade	
)


create table Dong
(
	MaDong int Identity(1,1),
	TenDong varchar(30),
	CONSTRAINT PK_Dong PRIMARY KEY(MaDong)	
)
Create Table Admin
(
    UserAdmin varchar (30) primary key,
    PassAdmin varchar (30) not null,
    Hoten nVarchar (50)
)
Insert into Admin values ('admin', '123456','Phạm Công Lý')
Insert into Admin values ('user','654321','Mr Lý')
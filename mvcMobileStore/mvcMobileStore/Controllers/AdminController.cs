﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using mvcMobileStore.Models;
using mvcMobileStore.Controllers;
using PagedList;
using PagedList.Mvc;
using System.IO;

namespace mvcMobileStore.Controllers
{
    public class AdminController : Controller
    {
        dbQLMobileDataContext db = new dbQLMobileDataContext();
        // GET: Admin
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult SanPham(int? page)
        {
            int pageNumber = (page ?? 1);
            int pageSize = 7;
            return View(db.SanPhams.ToList().OrderBy(n => n.MASP).ToPagedList(pageNumber, pageSize));
        }

        [HttpGet]
        public ActionResult Login()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Login(FormCollection collection)
        {
            // Gần các giá trị người dùng nhập liệu cho các biến
            var tendn = collection["username"];
            var matkhau = collection["password"];
            if (String.IsNullOrEmpty(tendn))
            {
                ViewData["Loi1"] = "Phải nhập tên đăng nhập";
            }
            else if (String.IsNullOrEmpty(matkhau))
            {
                ViewData["Loi2"] = "Phải nhập mật khẩu";
            }
            else
            {
                Admin ad = db.Admins.SingleOrDefault(n => n.UserAdmin == tendn && n.PassAdmin == matkhau);
                if (ad != null)
                {
                    // ViewBag.Thongbao = "Chúc mừng đăng nhập thành công";
                    Session["Taikhoanadmin"] = ad;
                    return RedirectToAction("Index", "Admin");
                }
                else
                {
                    ViewBag.Thongbao = "Tên đăng nhập hoặc mật khẩu không đúng";
                }

            }
            return View();
        }
        [HttpGet]
        public ActionResult Themdienthoaimoi()
        {
            ViewBag.MaDong = new SelectList(db.Dongs.ToList().OrderBy(n => n.TenDong), "MaDong", "TenDong");
            ViewBag.MaNPP = new SelectList(db.NPPs.ToList().OrderBy(n => n.TENNPP), "MaNPP", "TenNPP");
            ViewBag.MANCC = new SelectList(db.NCCs.ToList().OrderBy(n => n.TENNCC), "MANCC", "TenNCC");

            return View();
        }
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Themdienthoaimoi(SanPham sanpham, HttpPostedFileBase fileUpload)
        {
            ViewBag.MaDong = new SelectList(db.Dongs.ToList().OrderBy(n => n.TenDong), "MaDong", "TenDong");
            ViewBag.MaNPP = new SelectList(db.NPPs.ToList().OrderBy(n => n.TENNPP), "MaNPP", "TenNPP");
            ViewBag.MANCC = new SelectList(db.NCCs.ToList().OrderBy(n => n.TENNCC), "MANCC", "TenNCC");

            if (fileUpload == null)
            {
                ViewBag.Thongbao = "Vui lòng chọn ảnh bìa";
                return View();
            }
            //Them vao CSDL
            else
            {
                if (ModelState.IsValid)
                {
                    //Luu ten fie, luu y bo sung thu vien using System.I0;
                    var fileName = Path.GetFileName(fileUpload.FileName);
                    //Luu duong dan cua file
                    var path = Path.Combine(Server.MapPath("/Hinhsanpham"), fileName);
                    //Kiem tra hình anh ton tai chua?
                    if (System.IO.File.Exists(path))
                        ViewBag.Thongbao = "Hình ảnh đã tồn tại";
                    else
                    {
                        //Luu hinh anh vao duong dan
                        fileUpload.SaveAs(path);
                    }
                    sanpham.AnhSP = fileName;
                    //Luu vao CSDL
                    db.SanPhams.InsertOnSubmit(sanpham);
                    db.SubmitChanges();
                }
                return RedirectToAction("sanpham");

            }
        }
        public ActionResult Chitietsanpham(int id)
        {
            //Lay ra doi tuong sach theo ma
            SanPham sanpham = db.SanPhams.SingleOrDefault(n => n.MASP == id);
            ViewBag.MaSP = sanpham.MASP;
            if (sanpham == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            return View(sanpham);
        }
        public ActionResult Xoasanpham(int id)
        {
            // Lay ra doi tuong sach can xoa theo ma
            SanPham sanpham = db.SanPhams.SingleOrDefault(n => n.MASP == id);
            ViewBag.MaSP = sanpham.MASP;
            if (sanpham == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            return View(sanpham);
        }
        [HttpPost, ActionName("Xoasanpham")]
        public ActionResult Xacnhanxoa(int id)
        {
            //Lay ra doi tuong sach can xoa theo ma
            SanPham sanpham = db.SanPhams.SingleOrDefault(n => n.MASP == id);
            ViewBag.MaSP = sanpham.MASP;
            if (sanpham == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            db.SanPhams.DeleteOnSubmit(sanpham);
            db.SubmitChanges();
            return RedirectToAction("Sanpham");
        }
        [HttpGet]
        public ActionResult SuaSP(int id)
        {
            SanPham sanpham = db.SanPhams.SingleOrDefault(n => n.MASP == id);
            if (sanpham == null)
            {
                Response.StatusCode = 404;
                return null;

            }
            ViewBag.MaDong = new SelectList(db.Dongs.ToList().OrderBy(n => n.TenDong), "MaDong", "TenDong");
            ViewBag.MaNPP = new SelectList(db.NPPs.ToList().OrderBy(n => n.TENNPP), "MaNPP", "TenNPP",sanpham.MaNPP);
            ViewBag.MANCC = new SelectList(db.NCCs.ToList().OrderBy(n => n.TENNCC), "MANCC", "TenNCC", sanpham.MANCC);
            return View(sanpham);
        }
        public ActionResult SuaSP(SanPham sanpham, HttpPostedFileBase fileUpload)
        {
            //Dua du lieu vao dropdownload
            ViewBag.MaDong = new SelectList(db.Dongs.ToList().OrderBy(n => n.TenDong), "MaDong", "TenDong");
            ViewBag.MaNPP = new SelectList(db.NPPs.ToList().OrderBy(n => n.TENNPP), "MaNPP", "TenNPP", sanpham.MaNPP);
            ViewBag.MANCC = new SelectList(db.NCCs.ToList().OrderBy(n => n.TENNCC), "MANCC", "TenNCC", sanpham.MANCC);
            //Kiem tra duong dan file
            if (fileUpload == null)
            {
                ViewBag.Thongbao = "Vui lòng chọn ảnh bìa";
                return View();
            }
            //Them vao CSDL
            else
            {
                if (ModelState.IsValid)
                {
                    //Luu ten fie, luu y bo sung thu vien using System. IO;
                    var fileName = Path.GetFileName(fileUpload.FileName);
                    // Luu duong dan cua file
                    var path = Path.Combine(Server.MapPath("~/Hinhsanpham"), fileName);
                    //Kiem tra hình anh ton tai chua?
                    if (System.IO.File.Exists(path))
                        ViewBag.Thongbao = "Hình ảnh đã tồn tại";
                    else
                    {
                        //Luu hinh anh vao duong dan
                        fileUpload.SaveAs(path);
                        sanpham.AnhSP = fileName;
                        //Luu vao CSDL                  
                    } 
                    UpdateModel(sanpham);
                    db.SubmitChanges();    
                }
                return RedirectToAction("sanpham");
            }
        }
    }
}
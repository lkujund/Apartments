using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.Entity;
using App;

namespace App.Controllers
{
    public class ApartmentController : Controller
    {
        private readonly ModelContainer db = new ModelContainer();
        // GET: Apartment
        ~ApartmentController() 
        {
            db.Dispose();
        }
        public ActionResult Index()
        {
            return View(db.Apartments);
        }

        // GET: Apartment/Details/5
        public ActionResult Details(int? id)
        {
            return CommonAction(id);
        }

        private ActionResult CommonAction(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(System.Net.HttpStatusCode.BadRequest);
            }
            var apartment = db.Apartments
                .Include(a => a.UploadedFiles)
                .SingleOrDefault(a => a.IDApartment == id);
            if (apartment == null)
            {
                return HttpNotFound();
            }
            return View(apartment);
        }

        // GET: Apartment/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Apartment/Create
        [HttpPost]
        public ActionResult Create(Apartment apartment, IEnumerable<HttpPostedFileBase> files)
        {
            if (ModelState.IsValid)
            {
                apartment.UploadedFiles = new List<UploadedFile>();
                AddFiles(apartment, files);
                db.Apartments.Add(apartment);
                db.SaveChanges();
                return RedirectToAction(nameof(Index));
            }
            return View(apartment);
        }

        // GET: Apartment/Edit/5
        public ActionResult Edit(int? id)
        {
            return CommonAction(id);
        }

        // POST: Apartment/Edit/5
        [HttpPost]
        public ActionResult Edit(int id, IEnumerable<HttpPostedFileBase> files)
        {
            var apartment = db.Apartments.Find(id);
            if (TryUpdateModel(
                apartment,
                "",
                new string[] 
                { 
                    nameof(Apartment.Address),   
                    nameof(Apartment.City),   
                    nameof(Apartment.Contact)   
                }))
            {
                AddFiles(apartment, files);

                db.Entry(apartment).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction(nameof(Index));
            }
            return View(apartment);
        }

        private void AddFiles(Apartment apartment, IEnumerable<HttpPostedFileBase> files)
        {
            foreach (var file in files)
            {
                if (file != null && file.ContentLength > 0)
                {
                    var picture = new UploadedFile
                    {
                        ContentType = file.ContentType,
                        Name = file.FileName
                    };
                    using (var reader = new System.IO.BinaryReader(file.InputStream))
                    {
                        picture.Content = reader.ReadBytes(file.ContentLength);
                    }
                    apartment.UploadedFiles.Add(picture);
                }
            }
        }

        // GET: Apartment/Delete/5
        public ActionResult Delete(int? id)
        {
            return CommonAction(id);
        }

        // POST: Apartment/Delete/5
        [HttpPost]
        public ActionResult Delete(int id)
        {
            db.UploadedFiles.RemoveRange(db.UploadedFiles.Where(f => f.ApartmentIDApartment == id));
            db.Apartments.Remove(db.Apartments.Find(id));
            db.SaveChanges();
            return RedirectToAction(nameof(Index));
        }
    }
}

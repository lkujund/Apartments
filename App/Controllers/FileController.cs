using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace App.Controllers
{
    public class FileController : Controller
    {
        private readonly ModelContainer db = new ModelContainer();
        // GET: File
        ~FileController() 
        {
            db.Dispose();
        }
        public ActionResult Index(int id)
        {
            var uploadedFile = db.UploadedFiles.Find(id);
            return File(uploadedFile.Content, uploadedFile.ContentType);
        }
        public ActionResult Delete(int id)
        {
            var uploadedFile = db.UploadedFiles.Find(id);
            db.UploadedFiles.Remove(uploadedFile);
            db.SaveChanges();

            return Redirect(Request.UrlReferrer.AbsolutePath); // refresh caller
        }
    }
}
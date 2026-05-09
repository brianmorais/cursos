using Introducao.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Introducao.Controllers
{
    public class HomeController : Controller
    {
        // GET: Home
        public ActionResult Index()
        {
            var pessoa = new Pessoa
            {
                PessoaId = 1,
                Nome = "Brian",
                Tipo = "Administrador"
            };

            ViewData["PessoaId"] = pessoa.PessoaId;
            ViewData["Nome"] = pessoa.Nome;
            ViewData["Tipo"] = pessoa.Tipo;

            ViewBag.id = pessoa.PessoaId;
            ViewBag.nome = pessoa.Nome;
            ViewBag.tipo = pessoa.Tipo;

            //Outra forma
            //var pessoa2 = new Pessoa();
            //pessoa2.Nome = "Brian";
            //pessoa2.PessoaId = 2;
            //pessoa2.Tipo = "user";

            return View(pessoa);
        }

        public ActionResult Contatos()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Lista(Pessoa pessoa)
        {

            return View(pessoa);
        }

        /*
          
         [HttpPost]
         public ActionResult Lista(Pessoa pessoa)
         {
             ViewData["PessoaId"] = pessoa.PessoaId;
             ViewData["Nome"] = pessoa.Nome;
             ViewData["Tipo"] = pessoa.Tipo;

             return View();
         }
         [HttpPost]
         public ActionResult Lista(FormCollection form)
         {
             ViewData["PessoaId"] = form["PessoaId"];
             ViewData["Nome"] = form["Nome"];
             ViewData["Tipo"] = form["Tipo"];

             return View();
         }

         [HttpPost]
         public ActionResult Lista(int PessoaId, string Nome, string Tipo)
         {
             ViewData["PessoaId"] = PessoaId;
             ViewData["Nome"] = Nome;
             ViewData["Tipo"] = Tipo;

             return View();
         }
         */
    }
}
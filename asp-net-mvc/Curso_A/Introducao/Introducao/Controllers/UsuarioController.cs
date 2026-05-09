using Introducao.Models;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Introducao.Controllers
{
    public class UsuarioController : Controller
    {
        
        public ActionResult Usuario()
        {
            var usuario = new Usuario();
            return View(usuario);
        }

        [HttpPost]
        public ActionResult Usuario(Usuario usuario)
        {
            //if (string.IsNullOrEmpty(usuario.Nome))
            //{
            //    ModelState.AddModelError("Nome", "O campo nome é obrigatório");
            //}

            //if (string.IsNullOrEmpty(usuario.Senha) && string.IsNullOrEmpty(usuario.ConfirmarSenha))
            //{
            //    ModelState.AddModelError("", "O campo senha e confirmação de senha são obrigatórios");
            //}

            //if(usuario.Senha != usuario.ConfirmarSenha)
            //{
            //    ModelState.AddModelError("", "Senha diferente");
            //}

            //if(usuario.Idade < 1)
            //{
            //    ModelState.AddModelError("Idade", "Idade não pode ser menor que 1");
            //}

            if (ModelState.IsValid)
            {
                return View("Resultado", usuario);
            }
            return View(usuario);
        }

        public ActionResult Resultado(Usuario usuario)
        {
            return View(usuario);
        }

        public ActionResult LoginUnico(string login)
        {
            var bdExemplo = new Collection<string>
            {
                "Brian",
                "Leonardo",
                "Morais"
            };

            return Json(bdExemplo.All(x => x.ToLower() != login.ToLower()), JsonRequestBehavior.AllowGet);
        }
    }
}
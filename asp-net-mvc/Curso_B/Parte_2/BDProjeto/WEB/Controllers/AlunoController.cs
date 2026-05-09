using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using BDProjeto.Aplicacao;
using BDProjeto.Dominio;

namespace WEB.Controllers
{
    public class AlunoController : Controller
    {
        private UsuarioAplicacao app;
        public AlunoController()
        {
            app = UsuarioAplicacaoConstrutor.UsuarioApEF();
        }
        public ActionResult Index()
        {
            //var app = UsuarioAplicacaoConstrutor.UsuarioApADO();
            var listaAlunos = app.ListarTodos();
            return View(listaAlunos);
        }

        public ActionResult Cadastrar()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Cadastrar(Usuarios usuario)
        {
            if (ModelState.IsValid)
            {
                //var app = UsuarioAplicacaoConstrutor.UsuarioApADO();
                app.Salvar(usuario);
                return RedirectToAction("Index");
            }
            return View(usuario);
        }

        public ActionResult Editar(string id)
        {
            //var app = UsuarioAplicacaoConstrutor.UsuarioApADO();
            var usuario = app.ListarPorId(id);

            if(usuario == null)
            {
                return HttpNotFound();
            }
            return View(usuario);
        }

        [HttpPost]
        public ActionResult Editar(Usuarios usuario)
        {
            if (ModelState.IsValid)
            {
                //var app = UsuarioAplicacaoConstrutor.UsuarioApADO(); 
                app.Salvar(usuario);
                return RedirectToAction("Index");
            }
            return View(usuario);
        }

        public ActionResult Detalhes(string id)
        {
            //var app = UsuarioAplicacaoConstrutor.UsuarioApADO();
            var usuario = app.ListarPorId(id);

            if (usuario == null)
            {
                return HttpNotFound();
            }
            return View(usuario);
        }

        public ActionResult Excluir(string id)
        {
            //var app = UsuarioAplicacaoConstrutor.UsuarioApADO();
            var usuario = app.ListarPorId(id);

            if (usuario == null)
            {
                return HttpNotFound();
            }
            return View(usuario);
        }

        [HttpPost, ActionName("Excluir")]
        public ActionResult ExcluirConfirmado(string id)
        {
            //var app = UsuarioAplicacaoConstrutor.UsuarioApADO();
            var usuario = app.ListarPorId(id);
            app.Excluir(usuario);
            return RedirectToAction("Index");
        }
    }
}
using BDProjeto.Repositorio;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using BDProjeto.Dominio;
using System.Linq;
using BDProjeto.RepositorioADO;
using BDProjeto.Dominio.contrato;

namespace BDProjeto.Aplicacao
{
    public class UsuarioAplicacao
    {
        private readonly IRepositorio<Usuarios> repositorio;

        public UsuarioAplicacao(IRepositorio<Usuarios> repo)
        {
            repositorio = repo;
        }
        
        public void Salvar(Usuarios usuarios)
        {
            repositorio.Salvar(usuarios);
        }

        public void Excluir(Usuarios usuario)
        {
            
            repositorio.Excluir(usuario);
            
        }

        public IEnumerable<Usuarios> ListarTodos()
        {
            return repositorio.ListarTodos();
        }

        public Usuarios ListarPorId(string id)
        {
            return repositorio.ListarPorId(id);
        }
        
    }
}

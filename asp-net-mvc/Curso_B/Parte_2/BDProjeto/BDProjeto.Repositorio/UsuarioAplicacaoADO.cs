using BDProjeto.Repositorio;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using BDProjeto.Dominio;
using System.Linq;
using BDProjeto.Dominio.contrato;

namespace BDProjeto.RepositorioADO
{
    public class UsuarioAplicacaoADO : IRepositorio<Usuarios>
    {
        private db db;
        private void Inserir(Usuarios usuarios)
        {
            var strQuery = "";
            strQuery += "insert into usuarios(nome, cargo, date)";
            strQuery += string.Format(" values('{0}', '{1}', '{2}')", usuarios.Nome, usuarios.Cargo, usuarios.Data);
            using (db = new db())
            {
                db.ExecutaComando(strQuery);
            }
        }

        private void Alterar(Usuarios usuarios)
        {
            var strQuery = "";
            strQuery += " update usuarios set ";
            strQuery += string.Format("nome = '{0}',", usuarios.Nome);
            strQuery += string.Format("cargo = '{0}',", usuarios.Cargo);
            strQuery += string.Format("date = '{0}'", usuarios.Data);
            strQuery += string.Format(" where usuarioId = {0}", usuarios.Id);
            using (db = new db())
            {
                db.ExecutaComando(strQuery);
            }
        }

        public void Salvar(Usuarios usuarios)
        {
            if (usuarios.Id > 0)
            {
                Alterar(usuarios);
            }
            else
            {
                Inserir(usuarios);
            }
        }

        public void Excluir(Usuarios usuario)
        {
            using (db = new db())
            {
                var strQuery = string.Format(" delete from usuarios where usuarioId = {0}", usuario.Id);
                db.ExecutaComando(strQuery);
            }
        }

        public IEnumerable<Usuarios> ListarTodos()
        {
            using (db = new db())
            {
                var strQuery = " select * from usuarios";
                var retorno = db.ExecutaComandoComRetorno(strQuery);
                return ReaderEmLista(retorno);
            }
        }

        public Usuarios ListarPorId(string id)
        {
            using (db = new db())
            {
                var strQuery = string.Format(" select * from usuarios where usuarioId = {0}", id);
                var retorno = db.ExecutaComandoComRetorno(strQuery);
                return ReaderEmLista(retorno).FirstOrDefault();
            }
        }

        private List<Usuarios> ReaderEmLista (SqlDataReader reader)
        {
            var usuarios = new List<Usuarios>();
            while (reader.Read())
            {
                var tempoObjeto = new Usuarios()
                {
                    Id = int.Parse(reader["usuarioId"].ToString()),
                    Nome = reader["nome"].ToString(),
                    Cargo = reader["cargo"].ToString(),
                    Data = DateTime.Parse(reader["date"].ToString())
                };
                usuarios.Add(tempoObjeto);
            }
            reader.Close();
            return usuarios;
        }
    }
}

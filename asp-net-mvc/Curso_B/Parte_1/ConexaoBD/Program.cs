using BDProjeto.Aplicacao;
using BDProjeto.Dominio;
using System;
using System.Data.SqlClient;
using BDProjeto.Repositorio;

namespace DOS
{
    class Program
    {
        static void Main(string[] args)
        {
            var db = new db();

            var usuarioAplicacao = new UsuarioAplicacao();

            var usuario = new Usuarios();

            SqlConnection con = new SqlConnection(@"DATA SOURCE = (LOCAL)\SQLEXPRESS;
                                                    INITIAL CATALOG = ExemploBD;
                                                    USER ID = sa;
                                                    PASSWORD = admin");
            con.Open();

            //string update = "update usuarios set nome = 'Marcos' where usuarioId = 2";
            //SqlCommand cmdUpdate = new SqlCommand(update, con);
            //cmdUpdate.ExecuteNonQuery();

            //string delete = "delete from usuarios where usuarioId = 2";
            //SqlCommand cmdDelete = new SqlCommand(delete, con);
            //cmdDelete.ExecuteNonQuery();

            Console.WriteLine("Digite o nome: ");
            usuario.Nome = Console.ReadLine();

            Console.WriteLine("Digite o cargo: ");
            usuario.Cargo = Console.ReadLine();

            Console.WriteLine("Digite a data: ");
            usuario.Data = DateTime.Parse(Console.ReadLine());

            //string insert = string.Format("insert into usuarios(nome, cargo, date) values('{0}', '{1}', '{2}')", nome, cargo, data);
            //db.ExecutaComando(insert);

            usuarioAplicacao.Salvar(usuario);

            //usuarioAplicacao.Excluir(5);

            var drSelect = usuarioAplicacao.ListarTodos();

            foreach(var user in drSelect)
            {
                Console.WriteLine("Id: {0} - Nome: {1} - Cargo: {2} - Data: {3}", user.Id, user.Nome, user.Cargo, user.Data);
            }
            con.Close();
            Console.ReadKey();
        }

        

    }
}

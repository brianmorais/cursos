using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace BDProjeto.Repositorio
{
    public class db : IDisposable
    {
        private readonly SqlConnection conexao;
        public db()
        {
            conexao = new SqlConnection(ConfigurationManager.ConnectionStrings["conexaoBD"].ConnectionString);
            conexao.Open();
        }

        public void ExecutaComando(string strQuery)
        {
            var cmd = new SqlCommand
            {
                CommandText = strQuery,
                CommandType = CommandType.Text,
                Connection = conexao
            };
            cmd.ExecuteNonQuery();
        }

        public SqlDataReader ExecutaComandoComRetorno(string strQuery)
        {
            var cmdSelect = new SqlCommand(strQuery, conexao);
            return cmdSelect.ExecuteReader();
        }

        public void Dispose()
        {
            if (conexao.State == ConnectionState.Open)
            {
                conexao.Close();
            }
        }
    }
}

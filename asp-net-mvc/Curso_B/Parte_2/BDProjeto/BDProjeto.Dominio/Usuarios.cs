using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace BDProjeto.Dominio
{
    public class Usuarios
    {
        public int Id { get; set; }

        [DisplayName("Nome")]
        [Required(ErrorMessage = "Nome Obrigatório")]
        public string Nome { get; set; }

        [DisplayName("Cargo")]
        [Required(ErrorMessage = "Cargo Obrigatório")]
        public string Cargo { get; set; }

        [DisplayName("Data")]
        [Required(ErrorMessage = "Data Obrigatória")]
        [DisplayFormat(ApplyFormatInEditMode = true, DataFormatString = "{0:dd/MM/yyyy}")]
        public DateTime Data { get; set; }
    }
}

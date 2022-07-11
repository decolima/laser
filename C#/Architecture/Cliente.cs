using System;
namespace Rest.Domain.Entitys
{
    public class Cliente : Base
    {
        public Cliente()
        {
        }

        public string Nome { get; set; }

        public string Sobrenome { get; set; }

        public string Email { get; set; }

        public DateTime DataCadastro { get; set; }

        public bool IsAtivo { get; set; }

    }
}


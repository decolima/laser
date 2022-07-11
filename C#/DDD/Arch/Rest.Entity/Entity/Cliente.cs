using System;
namespace Rest.Entity.Entity
{
    public class Cliente : Base
    {
        public Cliente()
        {
        }

        public string Nome { get; set; }

        public string Sobrenome { get; set; }

        public string  Email { get; set; }

        public DateTime DataCadastro { get; set; }

        public bool isAtivo { get; set; }
    }
}


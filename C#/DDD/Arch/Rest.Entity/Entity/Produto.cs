using System;
namespace Rest.Entity.Entity
{
    public class Produto : Base
    {
        public Produto()
        {
        }

        public String Nome { get; set; }

        public decimal Valor { get; set; }

        public bool isDisponivel { get; set; }
    }
}


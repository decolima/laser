using System;


namespace Rest.Domain.Entitys
{
    public class Produto : Base
    {
        public Produto()
        {
        }

        public string Nome { get; set; }

        public decimal Valor { get; set; }

        public bool IsDisponivel { get; set; }

    }
}


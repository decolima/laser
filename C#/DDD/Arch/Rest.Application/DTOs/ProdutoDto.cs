using System;
namespace Rest.Application.DTOs
{
    public class ProdutoDto
    {
        public ProdutoDto()
        {
        }

        public int? Id { get; set; }

        public string Nome { get; set; }

        public decimal Valor { get; set; }


    }
}


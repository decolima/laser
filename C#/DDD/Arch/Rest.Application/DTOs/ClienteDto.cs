using System;
namespace Rest.Application.DTOs
{
    public class ClienteDto
    {
        public ClienteDto()
        {
        }


        public int? Id { get; set; }

        public string  Nome { get; set; }

        public string Sobrenome { get; set; }

        public string Email { get; set; }


    }
}


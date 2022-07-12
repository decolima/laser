using System;
using Rest.Application.DTOs;

namespace Rest.Application.Interfaces
{
    public interface IAppServiceCliente
    {

        void Add(ClienteDto clienteDto);

        void Update(ClienteDto clienteDto);

        void Remove(ClienteDto clienteDto);

        IEnumerable<ClienteDto> GetAll();

        ClienteDto GetById(int id);

    }
}


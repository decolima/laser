using System;
using Rest.Application.DTOs;
using Rest.Entity.Entity;

namespace Rest.Application.Interfaces.Mappers
{
    public interface IMapperCliente
    { 
    
        Cliente MapperDtoToEntity(ClienteDto clienteDto);

        IEnumerable<ClienteDto> MapperListClientesDto(IEnumerable<Cliente> clientes);

        ClienteDto MapperEntityToDto(Cliente cliente);

    }
}


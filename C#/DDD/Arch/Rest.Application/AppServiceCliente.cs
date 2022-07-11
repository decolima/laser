using System;
using Rest.Application.DTOs;
using Rest.Application.Interfaces;
using Rest.Application.Interfaces.Mappers;
using Rest.Core.Entity.Interfaces.Services;

namespace Rest.Application
{
    public class AppServiceCliente : IAppServiceCliente
    {
        private readonly IServiceCliente serviceCliente;

        private readonly IMapperCliente mapperCliente;

        public AppServiceCliente(IServiceCliente serviceCliente, IMapperCliente mapperCliente)
        {
            this.serviceCliente = serviceCliente;
            this.mapperCliente = mapperCliente;
        }

        public void Add(ClienteDto clienteDto)
        {
            var cliente = mapperCliente.MapperDtoToEntity(clienteDto);
            serviceCliente.Add(cliente);
        }

        public IEnumerable<ClienteDto> GetAll()
        {
            var clientes = serviceCliente.GetAll();

            return mapperCliente.MapperListClientesDto(clientes);

        }

        public ClienteDto GetById(int id)
        {

            var cliente = serviceCliente.GetById(id);
            return mapperCliente.MapperEntityToDto(cliente);
        }

        public void Remove(ClienteDto clienteDto)
        {

            var cliente = mapperCliente.MapperDtoToEntity(clienteDto);
            serviceCliente.Remove(cliente);

        }

        public void Update(ClienteDto clienteDto)
        {

            var cliente = mapperCliente.MapperDtoToEntity(clienteDto);
            serviceCliente.Update(cliente);
        }
    }
}


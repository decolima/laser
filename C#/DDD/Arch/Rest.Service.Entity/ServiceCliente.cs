using System;
using Rest.Core.Entity.Interfaces.Repositorys;
using Rest.Core.Entity.Interfaces.Services;
using Rest.Entity.Entity;

namespace Rest.Service.Entity
{
    public class ServiceCliente : ServiceBase<Cliente>, IServiceCliente
    {
        private readonly IRepositoryCliente repositoryCliente;

        public ServiceCliente(IRepositoryCliente repositoryCliente) : base (repositoryCliente)
        {
            this.repositoryCliente = repositoryCliente;
        }
    }
}


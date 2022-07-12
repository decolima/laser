using System;
using Rest.Core.Entity.Interfaces.Repositorys;
using Rest.Core.Entity.Interfaces.Services;
using Rest.Entity.Entity;

namespace Rest.Service.Entity
{
    public class ServiceProduto : ServiceBase<Produto>, IServiceProduto
    {
        private readonly IRepositoryProduto repositoryProduto;

        public ServiceProduto(IRepositoryProduto repositoryProduto) : base(repositoryProduto)
        {
            this.repositoryProduto = repositoryProduto;
        }
    }
}


using System;
using Autofac;
using Rest.Application;
using Rest.Application.Interfaces;
using Rest.Application.Interfaces.Mappers;
using Rest.Core.Entity.Interfaces.Repositorys;
using Rest.Core.Entity.Interfaces.Services;
using Rest.Infrastructure.Data.Repository;
using Rest.Service.Entity;

namespace Rest.Infrastructure.CrossCutting.IOC
{
    public class ConfigurationIOC
    {
        public ConfigurationIOC()
        {
        }

        public static void Load (ContainerBuilder builder)
        {

            #region IOC

            builder.RegisterType<AppServiceCliente>().As<IAppServiceCliente>();

            builder.RegisterType<AppServiceProduto>().As<IAppServiceProduto>();

            builder.RegisterType<ServiceCliente>().As<IServiceCliente>();

            builder.RegisterType<ServiceProduto>().As<IServiceProduto>();

            builder.RegisterType<RepositoryCliente>().As<IRepositoryCliente>();

            builder.RegisterType<RepositoryProduto>().As<IRepositoryProduto>();

            builder.RegisterType<MapperCliente>().As<IMapperCliente>();

            builder.RegisterType<MapperProduto>().As<IMapperProduto>();

            #endregion

        }


    }
}


using System;
using Rest.Core.Entity.Interfaces.Repositorys;
using Rest.Entity.Entity;

namespace Rest.Infrastructure.Data.Repository
{
    public class RepositoryCliente : RepositoryBase<Cliente>, IRepositoryCliente
    {

        private readonly SqlContext sqlContext;

        public RepositoryCliente(SqlContext sqlContext) : base (sqlContext)
        {
            this.sqlContext = sqlContext;
        }
    }
}


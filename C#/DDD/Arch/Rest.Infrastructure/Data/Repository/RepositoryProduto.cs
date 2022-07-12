using System;
using Rest.Core.Entity.Interfaces.Repositorys;
using Rest.Entity.Entity;

namespace Rest.Infrastructure.Data.Repository
{
    public class RepositoryProduto : RepositoryBase<Produto>, IRepositoryProduto
    {

        private readonly SqlContext sqlContext;

        public RepositoryProduto(SqlContext sqlContext) : base(sqlContext)
        {
            this.sqlContext = sqlContext;
        }
    }
}




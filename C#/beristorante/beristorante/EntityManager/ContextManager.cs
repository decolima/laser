using System;
using beristorante.Entity;
using Microsoft.EntityFrameworkCore;

namespace beristorante.EntityManager
{
    public class ContextManager : DbContext
    {
        public ContextManager(DbContextOptions<ContextManager> options) : base(options)
        {
        }

        public DbSet<Prodotto> Prodotto { get; set; }

        public DbSet<ProdottoPrezzo> ProdottiPrezzi { get; set; }

        public DbSet<Menu> Menu { get; set; }
         
        public DbSet<Ristorante> Ristorante { get; set; }

    }

}


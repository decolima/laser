using System.Data.Entity.ModelConfiguration.Conventions;
using System.Data.Entity;
using Recipes.Models;
using DbContext = Microsoft.EntityFrameworkCore.DbContext;

namespace Recipes.ModelContext
{
    public class RecipesContext : DbContext
    {
        public RecipesContext() : base()
        {
        }

        public Microsoft.EntityFrameworkCore.DbSet<Recipe> Recipes { get; set; }

        public Microsoft.EntityFrameworkCore.DbSet<Ingredient> Ingredients { get; set; }

        public Microsoft.EntityFrameworkCore.DbSet<User> Users { get; set; }


        protected void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Conventions.Remove<PluralizingTableNameConvention>();
        }

    }
}


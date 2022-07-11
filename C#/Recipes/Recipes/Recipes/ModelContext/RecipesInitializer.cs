using System.Data.Entity;
namespace Recipes.ModelContext
{
    public class RecipesInitializer : DropCreateDatabaseIfModelChanges<RecipesContext>
    {


        protected override void Seed(RecipesContext context)
        {

        }

     }  
}


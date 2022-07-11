using System;
using System.ComponentModel.DataAnnotations;

namespace Recipes.Models
{
    public class Recipe
    {

        [Key]
        public int ID { get; set; }

        [Required]
        public string Name { get; set; }

        public string HowtoMake { get; set; }

        public ICollection<Ingredient> Ingredients { get; set; }
    }


}


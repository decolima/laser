using System;
using System.ComponentModel.DataAnnotations;

namespace Recipes.Models
{
    public class Ingredient
    {

        [Key]
        public int ID { get; set; }

        [Required]
        public string Name { get; set; }


    }
}


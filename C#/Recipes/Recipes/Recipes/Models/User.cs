﻿using System;
using System.ComponentModel.DataAnnotations;

namespace Recipes.Models
{
    public class User
    {

        [Key]
        public int ID { get; set; }

        [Required]
        public string Name { get; set; }

        [Required]
        public string Email { get; set; }

        [Required]
        public string Pwd { get; set; }

    }
}


using System;

namespace beristorante.Entity
{
    public class Prodotto : BaseEntity
    {
        public Prodotto()
        {
        }

        public String Descrizione { get; set; }

        public String Nome { get; set; }

        public String Tipo { get; set; }

    }
}


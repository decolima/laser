using System;
namespace beristorante.Entity
{
    public class Menu : BaseEntity
    {
        public Menu()
        {
        }

        public String Descrizione { get; set; }

        public Boolean Disponibile { get; set; }

        public Boolean Takeaway { get; set; }

        public String Tipo { get; set; }

        public int Ristorante_id { get; set; }

    }
}


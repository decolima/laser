using System;
namespace beristorante.Entity
{
    public class Ristorante : BaseEntity
    {
        public Ristorante()
        {
        }

        public String Nome { get; set; }

        public String Indirizzo { get; set; }

        public String Responsabile { get; set; }

        public String Telefono { get; set; }

        
    }
}


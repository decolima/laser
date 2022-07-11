using System;
namespace beristorante.Entity
{
    public class BaseEntity
    {
        public BaseEntity()
        {
        }

        public int Id { get; set; }

        public Boolean Cancellato {get; set;}

        public int Version { get; set; }

    }
}


using Microsoft.EntityFrameworkCore;

namespace Livraria.Models
{
    public class LivroContexto : DbContext
    {
        public LivroContexto(DbContextOptions<LivroContexto> options) : base(options)
        {
        }
        public DbSet<Livro> Livros { get; set; }
    }
}

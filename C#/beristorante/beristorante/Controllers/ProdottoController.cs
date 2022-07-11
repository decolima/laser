using System;
using beristorante.Entity;
using beristorante.EntityManager;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace beristorante.Controllers
{

    [ApiController]
    [Route("[controller]")]
    public class ProdottoController
    {

        private ContextManager _context;

        public ProdottoController(ContextManager context)
        {
            _context = context;
        }


        // GET:
        [HttpGet(Name = "GetProdotto")]
        public  List<Prodotto> Get()
        {
            Console.WriteLine("entrou no metodo get");

            Console.WriteLine(_context.GetType().ToString());

            return _context.Prodotto.ToList();
        }
    }
}


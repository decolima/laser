using System;
using Rest.Application.DTOs;

namespace Rest.Application.Interfaces
{
    public interface IAppServiceProduto
    {

        void Add(ProdutoDto produtoDto);

        void Update(ProdutoDto produtoDto);

        void Remove(ProdutoDto produtoDto);

        IEnumerable<ProdutoDto> GetAll();

        ProdutoDto GetById(int id);

    }
}


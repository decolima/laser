using System;
using Rest.Application.DTOs;
using Rest.Entity.Entity;

namespace Rest.Application.Interfaces.Mappers
{
    public interface IMapperProduto
    {

        Produto MapperDtoToEntity(ProdutoDto produtoDto);

        IEnumerable<ProdutoDto> MapperListProdutoDto(IEnumerable<Produto> produtos);

        ProdutoDto MapperEntityToDto(Produto produto);


    }
}


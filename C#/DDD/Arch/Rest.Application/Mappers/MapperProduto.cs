using System;
using Rest.Application.DTOs;
using Rest.Application.Interfaces.Mappers;
using Rest.Entity.Entity;



namespace Rest.Application.Interfaces
{
    public class MapperProduto : IMapperProduto
    {
        IEnumerable<ProdutoDto> produtoDtos = new List<ProdutoDto>();

        public MapperProduto()
        {
        }

        public Produto MapperDtoToEntity(ProdutoDto produtoDto)
        {
            var produto = new Produto()
            {
                Id = (int)produtoDto.Id,
                Nome = produtoDto.Nome,
                Valor = produtoDto.Valor
            };

            return produto;
        }

        public ProdutoDto MapperEntityToDto(Produto produto)
        {
            var produtoDto = new ProdutoDto()
            {
                Id = produto.Id,
                Nome = produto.Nome,
                Valor = produto.Valor
            };

            return produtoDto;

        }


        public IEnumerable<ProdutoDto> MapperListProdutoDto(IEnumerable<Produto> produtos)
        {
            var dto = produtos.Select(p => new ProdutoDto
                                                            {
                                                                Id = p.Id,
                                                                Nome = p.Nome,
                                                                Valor = p.Valor
                                                            }
                                        );

            return dto;
        }
    }
}


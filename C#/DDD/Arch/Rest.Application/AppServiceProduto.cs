using System;
using Rest.Application.DTOs;
using Rest.Application.Interfaces.Mappers;
using Rest.Core.Entity.Interfaces.Services;

namespace Rest.Application
{
    public class AppServiceProduto
    {

        private readonly IServiceProduto serviceProduto;

        private readonly IMapperProduto mapperProduto;

        public AppServiceProduto(IServiceProduto serviceProduto, IMapperProduto mapperProduto)
        {
            this.serviceProduto = serviceProduto;
            this.mapperProduto = mapperProduto;
        }

        public void Add(ProdutoDto produtoDto)
        {
            var produto = mapperProduto.MapperDtoToEntity(produtoDto);
            serviceProduto.Add(produto);
        }

        public IEnumerable<ProdutoDto> GetAll()
        {
            var produtos = serviceProduto.GetAll();

            return mapperProduto.MapperListProdutoDto(produtos);

        }

        public ProdutoDto GetById(int id)
        {

            var produto = serviceProduto.GetById(id);
            return mapperProduto.MapperEntityToDto(produto);
        }

        public void Remove(ProdutoDto produtoDto)
        {

            var produto = mapperProduto.MapperDtoToEntity(produtoDto);
            serviceProduto.Remove(produto);

        }

        public void Update(ProdutoDto produtoDto)
        {

            var produto = mapperProduto.MapperDtoToEntity(produtoDto);
            serviceProduto.Update(produto);
        }

    }
}


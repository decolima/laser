using System;
using Autofac;

namespace Rest.Infrastructure.CrossCutting.IOC
{
    public class ModuleIOC : Module
    {
        public ModuleIOC()
        {
        }

        protected override void Load (ContainerBuilder builder)
        {

            ConfigurationIOC.Load(builder);

        }

    }
}


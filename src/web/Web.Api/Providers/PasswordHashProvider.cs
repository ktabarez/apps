using Microsoft.AspNet.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Web.Api
{
    public interface IPasswordHashPovider : IPasswordHasher, IDisposable
    {

    }

    public class PasswordHashProvider : PasswordHasher, IPasswordHashPovider, IPasswordHasher
    {
        public PasswordHashProvider()
            :base()
        {

        }

        public void Dispose()
        {

        }
    }
}
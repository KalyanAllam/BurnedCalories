using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(BurnedCalories.Startup))]
namespace BurnedCalories
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}

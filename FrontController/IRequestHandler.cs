using System.Web;

namespace CreekPortal.Web.FrontController
{
    public interface IRequestHandler
    {
        bool HandleRequest(HttpContextBase context);
    }
}
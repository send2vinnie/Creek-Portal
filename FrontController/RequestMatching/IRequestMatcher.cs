using System.Web;

namespace CreekPortal.Web.FrontController.RequestMatching
{
    public interface IRequestMatcher
    {
        bool CanProcessRequest(HttpRequestBase request);
    }
}
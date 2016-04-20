using System.Web;

namespace CreekPortal.Web.FrontController.RequestMatching
{
    public class CatchAllRequestMatcher : IRequestMatcher
    {
        public bool CanProcessRequest(HttpRequestBase request)
        {
            return true;
        }
    }
}
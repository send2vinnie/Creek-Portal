using System.Web;

namespace CreekPortal.Web.FrontController.RequestMatching
{
    public class SingleParamRequestMatcher : IRequestMatcher
    {
        private readonly string _parameter;

        private readonly string _value;

        public SingleParamRequestMatcher(string parameter, string value)
        {
            _parameter = parameter;
            _value = value;
        }

        public bool CanProcessRequest(HttpRequestBase request)
        {
            var value = request.Params[_parameter];
            if (string.IsNullOrEmpty(value))
            {
                return false;
            }

            return value == _value;
        }
    }
}
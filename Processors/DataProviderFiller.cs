using System.Web;
using Creek.Controller;

namespace CreekPortal.Web.Processors
{
    using FrontController.ResponseFilling;

    public abstract class DataProviderFiller : IResponseFiller
    {
        protected readonly IRemotableCreekController _creekController;

        protected DataProviderFiller(IRemotableCreekController creekController)
        {
            _creekController = creekController;
        }

        public void FillResponse(HttpResponseBase response, HttpContextBase context)
        {
            DoAction(response, context);
            response.End();
        }

        protected abstract void DoAction(HttpResponseBase response, HttpContextBase context);
    }
}
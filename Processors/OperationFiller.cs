using System.Web;
using Creek.Controller;

namespace CreekPortal.Web.Processors
{
    using FrontController.ResponseFilling;

    public abstract class OperationFiller : IResponseFiller
    {
        protected readonly IRemotableCreekController _creekController;

        protected OperationFiller(IRemotableCreekController creekController)
        {
            _creekController = creekController;
        }

        public void FillResponse(HttpResponseBase response, HttpContextBase context)
        {
            DoAction(response, context);
            if (context.Request.UrlReferrer != null)
            {
                response.Redirect(context.Request.UrlReferrer.OriginalString);
            }
            else
            {
                response.End();
            }
        }

        protected abstract void DoAction(HttpResponseBase response, HttpContextBase context);
    }
}
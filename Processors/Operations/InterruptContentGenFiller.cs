using System.Web;
using Creek.Controller;

namespace CreekPortal.Web.Processors.Operations
{
    public class InterruptContentGenFiller : OperationFiller
    {
        public InterruptContentGenFiller(IRemotableCreekController creekController)
            : base(creekController)
        {
        }

        protected override void DoAction(HttpResponseBase response, HttpContextBase context)
        {
            string sContentId = context.Request.Params["content_id"];
            _creekController.InterruptContentGenReq(sContentId);
        }
    }
}
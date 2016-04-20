using System.Web;
using Creek.Controller;

namespace CreekPortal.Web.Processors.Operations
{
    public class OfflineContentFiller : OperationFiller
    {
        public OfflineContentFiller(IRemotableCreekController creekController)
            : base(creekController)
        {
        }

        protected override void DoAction(HttpResponseBase response, HttpContextBase context)
        {
            string sContentId = context.Request.Params["content_id"];
            string sContentHash = context.Request.Params["content_hash"];
            _creekController.OfflineContentVersionReq(sContentId, sContentHash);
        }
    }
}
using System.Web;
using Creek.Controller;

namespace CreekPortal.Web.Processors.Operations
{
    public class ContentGenFiller : OperationFiller
    {
        public ContentGenFiller(IRemotableCreekController creekController)
            : base(creekController)
        {
        }

        protected override void DoAction(HttpResponseBase response, HttpContextBase context)
        {
            string sContentId = context.Request.Params["content_id"];
            string sContentRecipes = context.Request.Params["content_gen_recipes"];
            _creekController.GenerateContentReq(sContentId, sContentRecipes);
        }
    }
}
using System;
using System.Web;
using System.Collections.Generic;
using Creek.Controller;
using Creek.JsonObject;
using Newtonsoft.Json;

namespace CreekPortal.Web.Processors.DataProviders
{
    public class QueryContentRecipesJsonFiller : DataProviderFiller
    {
        public QueryContentRecipesJsonFiller(IRemotableCreekController creekController)
            : base(creekController)
        {
        }

        protected override void DoAction(HttpResponseBase response, HttpContextBase context)
        {
            string sContentId = context.Request.Params["content_id"];
            string sContentHash = context.Request.Params["content_hash"];
            string sJson;

            sJson = _creekController.GetContentGenRecipesJson(sContentId, sContentHash);
            response.ContentType = "application/json";
            response.Write(sJson);
        }
    }
}
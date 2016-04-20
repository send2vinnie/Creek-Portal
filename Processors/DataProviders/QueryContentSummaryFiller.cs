using System;
using System.Web;
using System.Collections.Generic;
using Creek.Controller;
using Creek.JsonObject;
using Newtonsoft.Json;

namespace CreekPortal.Web.Processors.DataProviders
{
    public class QueryContentSummaryFiller : DataProviderFiller
    {
        public QueryContentSummaryFiller(IRemotableCreekController creekController)
            : base(creekController)
        {
        }

        protected override void DoAction(HttpResponseBase response, HttpContextBase context)
        {
            string sContentId = context.Request.Params["content_id"];
            string sJson;
            List<ContentSummaryProperty> listContentSummaryProperty = new List<ContentSummaryProperty>();

            foreach (Tuple<string, string> contentSummaryProperty in
                _creekController.GetContentSummary(sContentId))
            {
                ContentSummaryProperty oCSP = new ContentSummaryProperty()
                {
                    Name =  contentSummaryProperty.Item1.ToString(),
                    Value = contentSummaryProperty.Item2.ToString()
                };
                listContentSummaryProperty.Add(oCSP);
            }
            sJson = JsonConvert.SerializeObject(listContentSummaryProperty);
            response.ContentType = "application/json";
            response.Write(sJson);
        }
    }
}
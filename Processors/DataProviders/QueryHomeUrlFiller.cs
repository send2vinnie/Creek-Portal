using System;
using System.Web;
using System.Collections.Generic;
using Creek.Controller;
using Creek.JsonObject;
using Newtonsoft.Json;

namespace CreekPortal.Web.Processors.DataProviders
{
    public class QueryHomeUrlFiller : DataProviderFiller
    {
        public QueryHomeUrlFiller(IRemotableCreekController creekController)
            : base(creekController)
        {
        }

        protected override void DoAction(HttpResponseBase response, HttpContextBase context)
        {
            string sContentId = context.Request.Params["content_id"];
            string sJson;
            List<HistoryComboNode> listHomeUrl = new List<HistoryComboNode>();

            foreach (string sHomeUrl in _creekController.GetDownloaderHomeUrlHistory(sContentId))
            {
                listHomeUrl.Add(new HistoryComboNode()
                {
                    id = listHomeUrl.Count.ToString(),
                    text = sHomeUrl
                });
            }
            sJson = JsonConvert.SerializeObject(listHomeUrl);
            response.ContentType = "application/json";
            response.Write(sJson);
        }
    }
}
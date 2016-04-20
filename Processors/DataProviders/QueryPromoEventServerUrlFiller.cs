using System;
using System.Web;
using System.Collections.Generic;
using Creek.Controller;
using Creek.JsonObject;
using Newtonsoft.Json;

namespace CreekPortal.Web.Processors.DataProviders
{
    public class QueryPromoEventServerUrlFiller : DataProviderFiller
    {
        public QueryPromoEventServerUrlFiller(IRemotableCreekController creekController)
            : base(creekController)
        {
        }

        protected override void DoAction(HttpResponseBase response, HttpContextBase context)
        {
            string sContentId = context.Request.Params["content_id"];
            string sJson;
            List<HistoryComboNode> listPromoEventServerUrl = new List<HistoryComboNode>();

            foreach (string sPromoEventServerUrl in _creekController.GetDownloaderPromoEventServerUrlHistory(sContentId))
            {
                listPromoEventServerUrl.Add(new HistoryComboNode()
                {
                    id = listPromoEventServerUrl.Count.ToString(),
                    text = sPromoEventServerUrl
                });
            }
            sJson = JsonConvert.SerializeObject(listPromoEventServerUrl);
            response.ContentType = "application/json";
            response.Write(sJson);
        }
    }
}
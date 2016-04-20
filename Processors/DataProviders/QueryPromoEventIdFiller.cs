using System;
using System.Web;
using System.Collections.Generic;
using Creek.Controller;
using Creek.JsonObject;
using Newtonsoft.Json;

namespace CreekPortal.Web.Processors.DataProviders
{
    public class QueryPromoEventIdFiller : DataProviderFiller
    {
        public QueryPromoEventIdFiller(IRemotableCreekController creekController)
            : base(creekController)
        {
        }

        protected override void DoAction(HttpResponseBase response, HttpContextBase context)
        {
            string sContentId = context.Request.Params["content_id"];
            string sJson;
            List<HistoryComboNode> listPromoEventId = new List<HistoryComboNode>();

            foreach (string sPromoEventId in _creekController.GetDownloaderPromoEventIdHistory(sContentId))
            {
                listPromoEventId.Add(new HistoryComboNode()
                {
                    id = listPromoEventId.Count.ToString(),
                    text = sPromoEventId
                });
            }
            sJson = JsonConvert.SerializeObject(listPromoEventId);
            response.ContentType = "application/json";
            response.Write(sJson);
        }
    }
}
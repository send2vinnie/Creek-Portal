using System;
using System.Web;
using System.Collections.Generic;
using Creek.Controller;
using Creek.JsonObject;
using Newtonsoft.Json;

namespace CreekPortal.Web.Processors.DataProviders
{
    public class QueryGaProfileIdFiller : DataProviderFiller
    {
        public QueryGaProfileIdFiller(IRemotableCreekController creekController)
            : base(creekController)
        {
        }

        protected override void DoAction(HttpResponseBase response, HttpContextBase context)
        {
            string sContentId = context.Request.Params["content_id"];
            string sJson;
            List<HistoryComboNode> listGaProfileId = new List<HistoryComboNode>();

            foreach (string sGaProfileId in _creekController.GetDownloaderGAProfileIdHistory(sContentId))
            {
                listGaProfileId.Add(new HistoryComboNode()
                {
                    id = listGaProfileId.Count.ToString(),
                    text = sGaProfileId
                });
            }
            sJson = JsonConvert.SerializeObject(listGaProfileId);
            response.ContentType = "application/json";
            response.Write(sJson);
        }
    }
}
using System;
using System.Web;
using System.Collections.Generic;
using Creek.Controller;
using Creek.JsonObject;
using Newtonsoft.Json;

namespace CreekPortal.Web.Processors.DataProviders
{
    public class QueryOnlineFaqUrlFiller : DataProviderFiller
    {
        public QueryOnlineFaqUrlFiller(IRemotableCreekController creekController)
            : base(creekController)
        {
        }

        protected override void DoAction(HttpResponseBase response, HttpContextBase context)
        {
            string sContentId = context.Request.Params["content_id"];
            string sJson;
            List<HistoryComboNode> listOnlineFaqUrl = new List<HistoryComboNode>();

            foreach (string sOnlineFaqUrl in _creekController.GetDownloaderOnlineFaqUrlHistory(sContentId))
            {
                listOnlineFaqUrl.Add(new HistoryComboNode()
                {
                    id = listOnlineFaqUrl.Count.ToString(),
                    text = sOnlineFaqUrl
                });
            }
            sJson = JsonConvert.SerializeObject(listOnlineFaqUrl);
            response.ContentType = "application/json";
            response.Write(sJson);
        }
    }
}
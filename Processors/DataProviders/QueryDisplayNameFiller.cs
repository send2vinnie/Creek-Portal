using System;
using System.Web;
using System.Collections.Generic;
using Creek.Controller;
using Creek.JsonObject;
using Newtonsoft.Json;

namespace CreekPortal.Web.Processors.DataProviders
{
    public class QueryDisplayNameFiller : DataProviderFiller
    {
        public QueryDisplayNameFiller(IRemotableCreekController creekController)
            : base(creekController)
        {
        }

        protected override void DoAction(HttpResponseBase response, HttpContextBase context)
        {
            string sContentId = context.Request.Params["content_id"];
            string sJson;
            List<HistoryComboNode> listDisplayName = new List<HistoryComboNode>();

            foreach (string sDisplayName in _creekController.GetDownloaderDisplayNameHistory(sContentId))
            {
                listDisplayName.Add(new HistoryComboNode()
                {
                    id = listDisplayName.Count.ToString(),
                    text = sDisplayName
                });
            }
            sJson = JsonConvert.SerializeObject(listDisplayName);
            response.ContentType = "application/json";
            response.Write(sJson);
        }
    }
}
using System;
using System.Web;
using System.Collections.Generic;
using Creek.Controller;
using Creek.JsonObject;
using Newtonsoft.Json;

namespace CreekPortal.Web.Processors.DataProviders
{
    public class QueryContentListFiller : DataProviderFiller
    {
        public QueryContentListFiller(IRemotableCreekController creekController)
            : base(creekController)
        {
        }

        protected override void DoAction(HttpResponseBase response, HttpContextBase context)
        {
            string sJson;
            string sOnline = context.Request.Params["online"];
            string sOffline = context.Request.Params["offline"];
            List<ContentNode> listContents = new List<ContentNode>();

            foreach (Tuple<string, bool> oContent in _creekController.GetMonitoringContentList())
            {
                listContents.Add(new ContentNode()
                {
                    id = oContent.Item1.GetHashCode().ToString(),
                    text = oContent.Item1,
                    iconCls = oContent.Item2 ? sOnline : sOffline
                });
            }
            sJson = JsonConvert.SerializeObject(listContents);
            response.ContentType = "application/json";
            response.Write(sJson);
        }
    }
}
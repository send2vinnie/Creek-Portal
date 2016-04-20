using System;
using System.Web;
using System.Collections.Generic;
using Creek.Controller;
using Creek.JsonObject;
using Newtonsoft.Json;

namespace CreekPortal.Web.Processors.DataProviders
{
    public class QueryIconFileFiller : DataProviderFiller
    {
        public QueryIconFileFiller(IRemotableCreekController creekController)
            : base(creekController)
        {
        }

        protected override void DoAction(HttpResponseBase response, HttpContextBase context)
        {
            string sJson;
            List<HistoryComboNode> listsIconFile = new List<HistoryComboNode>();

            foreach (string sIconFile in _creekController.GetIconFileList())
            {
                listsIconFile.Add(new HistoryComboNode()
                {
                    id = listsIconFile.Count.ToString(),
                    text = sIconFile
                });
            }
            sJson = JsonConvert.SerializeObject(listsIconFile);
            response.ContentType = "application/json";
            response.Write(sJson);
        }
    }
}
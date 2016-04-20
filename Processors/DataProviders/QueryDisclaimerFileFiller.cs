using System;
using System.Web;
using System.Collections.Generic;
using Creek.Controller;
using Creek.JsonObject;
using Newtonsoft.Json;

namespace CreekPortal.Web.Processors.DataProviders
{
    public class QueryDisclaimerFileFiller : DataProviderFiller
    {
        public QueryDisclaimerFileFiller(IRemotableCreekController creekController)
            : base(creekController)
        {
        }

        protected override void DoAction(HttpResponseBase response, HttpContextBase context)
        {
            string sJson;
            List<HistoryComboNode> listsDisclaimerFile = new List<HistoryComboNode>();

            foreach (string sDisclaimerFile in _creekController.GetDisclaimerFileList())
            {
                listsDisclaimerFile.Add(new HistoryComboNode()
                {
                    id = listsDisclaimerFile.Count.ToString(),
                    text = sDisclaimerFile
                });
            }
            sJson = JsonConvert.SerializeObject(listsDisclaimerFile);
            response.ContentType = "application/json";
            response.Write(sJson);
        }
    }
}
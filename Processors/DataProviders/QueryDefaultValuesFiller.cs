using System;
using System.Web;
using System.Xml;
using System.Collections.Generic;
using Creek.Controller;
using Creek.JsonObject;
using Newtonsoft.Json;

namespace CreekPortal.Web.Processors.DataProviders
{
    public class QueryDefaultValuesFiller : DataProviderFiller
    {
        public QueryDefaultValuesFiller(IRemotableCreekController creekController)
            : base(creekController)
        {
        }

        protected override void DoAction(HttpResponseBase response, HttpContextBase context)
        {
            string sJson;
            XmlDocument oDefaultValues = new XmlDocument();

            oDefaultValues.LoadXml(_creekController.GetDownloaderDefaultValues());
            sJson = JsonConvert.SerializeXmlNode(
                oDefaultValues.DocumentElement,
                Newtonsoft.Json.Formatting.None,
                true);
            response.ContentType = "application/json";
            response.Write(sJson);
        }
    }
}
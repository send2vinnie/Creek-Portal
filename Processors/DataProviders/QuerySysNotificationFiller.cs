using System;
using System.Web;
using System.Collections.Generic;
using Creek.Controller;
using Creek.JsonObject;
using Newtonsoft.Json;

namespace CreekPortal.Web.Processors.DataProviders
{
    public class QuerySysNotificationFiller : DataProviderFiller
    {
        public QuerySysNotificationFiller(IRemotableCreekController creekController)
            : base(creekController)
        {
        }

        protected override void DoAction(HttpResponseBase response, HttpContextBase context)
        {
            int nLeft;
            int nPage = int.Parse(context.Request.Params["page"]);
            int nRows = int.Parse(context.Request.Params["rows"]);
            string sJson;
            DataResult dataResult;
            List<SysNotification> listNotifications = new List<SysNotification>();

            foreach (Tuple<DateTime, string, string> log in
                _creekController.GetExecLog((nPage - 1) * nRows, nRows, out nLeft))
            {
                SysNotification oNotification = new SysNotification()
                {
                    Time = log.Item1.ToLocalTime().ToString(),
                    Level = log.Item2,
                    Message = log.Item3
                };
                listNotifications.Add(oNotification);
            }
            dataResult = new DataResult()
            {
                total = nPage * nRows + nLeft,
                rows = listNotifications
            };
            sJson = JsonConvert.SerializeObject(dataResult);
            response.ContentType = "application/json";
            response.Write(sJson);
        }
    }
}
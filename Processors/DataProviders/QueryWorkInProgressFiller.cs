using System;
using System.Web;
using System.Collections.Generic;
using Creek.Controller;
using Creek.JsonObject;
using Newtonsoft.Json;

namespace CreekPortal.Web.Processors.DataProviders
{
    public class QueryWorkInProgressFiller : DataProviderFiller
    {
        public QueryWorkInProgressFiller(IRemotableCreekController creekController)
            : base(creekController)
        {
        }

        protected override void DoAction(HttpResponseBase response, HttpContextBase context)
        {
            string sContentId = context.Request.Params["content_id"];
            string sJson;
            List<WorkInProgress> listWorkInProgress = new List<WorkInProgress>();

            foreach (Tuple<DateTime, string> workInProgress in
                _creekController.GetWorkInProgressList(sContentId))
            {
                WorkInProgress oWIP = new WorkInProgress()
                {
                    Time = workInProgress.Item1.ToLocalTime().ToString(),
                    Percentage = workInProgress.Item2
                };
                listWorkInProgress.Add(oWIP);
            }
            sJson = JsonConvert.SerializeObject(listWorkInProgress);
            response.ContentType = "application/json";
            response.Write(sJson);
        }
    }
}
using System;
using System.Web;
using System.Collections.Generic;
using Creek.Controller;
using Creek.JsonObject;
using Newtonsoft.Json;

namespace CreekPortal.Web.Processors.DataProviders
{
    public class QueryContentVersionListFiller : DataProviderFiller
    {
        public QueryContentVersionListFiller(IRemotableCreekController creekController)
            : base(creekController)
        {
        }

        protected override void DoAction(HttpResponseBase response, HttpContextBase context)
        {
            string sContentId = context.Request.Params["content_id"];
            string sJson;
            List<ContentVersion> listContentVersions = new List<ContentVersion>();

            foreach (Tuple<DateTime, string, string, bool, float, float> contentVersion in
                _creekController.GetContentVersionList(sContentId))
            {
                ContentVersion oCV = new ContentVersion()
                {
                    Time = contentVersion.Item1.ToString(),
                    Name = contentVersion.Item2,
                    Hash = contentVersion.Item3,
                    DeployToTracker = contentVersion.Item4,
                    SeedDeploymentRatio = contentVersion.Item5,
                    SeedingRatio = contentVersion.Item6
                };
                listContentVersions.Add(oCV);
            }
            sJson = JsonConvert.SerializeObject(listContentVersions);
            response.ContentType = "application/json";
            response.Write(sJson);
        }
    }
}
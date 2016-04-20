using System;
using System.Web;
using System.Collections.Generic;
using Creek.Controller;
using Creek.JsonObject;
using Newtonsoft.Json;

namespace CreekPortal.Web.Processors.DataProviders
{
    public class QuerySeedListFiller : DataProviderFiller
    {
        public QuerySeedListFiller(IRemotableCreekController creekController)
            : base(creekController)
        {
        }

        protected override void DoAction(HttpResponseBase response, HttpContextBase context)
        {
            string sJson;
            string sOnline = context.Request.Params["online"];
            string sOffline = context.Request.Params["offline"];
            string sTorrent = context.Request.Params["torrent"];
            List<SeedNode> listSeeds = new List<SeedNode>();

            foreach (Tuple<string, bool, string[]> oSeed in _creekController.GetMonitoringSeedList())
            {
                List<SeedNode> listTorrents = new List<SeedNode>();
                if (oSeed.Item3 != null)
                {
                    foreach (string sTorrentName in oSeed.Item3)
                    {
                        listTorrents.Add(new SeedNode()
                        {
                            id = sTorrentName,
                            text = sTorrentName,
                            iconCls = sTorrent,
                            children = null
                        });
                    }
                }
                listSeeds.Add(new SeedNode()
                {
                    id = oSeed.Item1,
                    text = oSeed.Item1,
                    iconCls = oSeed.Item2 ? sOnline : sOffline,
                    children = listTorrents
                });
            }
            sJson = JsonConvert.SerializeObject(listSeeds);
            response.ContentType = "application/json";
            response.Write(sJson);
        }
    }
}
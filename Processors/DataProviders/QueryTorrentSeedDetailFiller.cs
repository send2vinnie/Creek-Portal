using System;
using System.Web;
using System.Collections.Generic;
using Creek.Controller;
using Creek.JsonObject;
using Newtonsoft.Json;

namespace CreekPortal.Web.Processors.DataProviders
{
    public class QueryTorrentSeedDetailFiller : DataProviderFiller
    {
        public QueryTorrentSeedDetailFiller(IRemotableCreekController creekController)
            : base(creekController)
        {
        }

        protected override void DoAction(HttpResponseBase response, HttpContextBase context)
        {
            string sContentId = context.Request.Params["content_id"];
            string sContentHash = context.Request.Params["content_hash"];
            string sJson;
            List<TorrentSeed> listTorrentSeeds = new List<TorrentSeed>();

            foreach (Tuple<string, long, float, string, string> torrentSeed in
                _creekController.GetTorrentSeedDetail(sContentId, sContentHash))
            {
                TorrentSeed oTS = new TorrentSeed()
                {
                    IP = torrentSeed.Item1,
                    Size = torrentSeed.Item2,
                    Done = (float)Math.Round(torrentSeed.Item3, 3),
                    Status = torrentSeed.Item4,
                    Error = torrentSeed.Item5
                };
                listTorrentSeeds.Add(oTS);
            }
            sJson = JsonConvert.SerializeObject(listTorrentSeeds);
            response.ContentType = "application/json";
            response.Write(sJson);
        }
    }
}
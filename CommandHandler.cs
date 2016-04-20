using System.Collections.Generic;
using System.Configuration;
using Creek.Controller;

namespace CreekPortal.Web
{
    using FrontController;
    using FrontController.RequestMatching;
    using Processors;
    using Processors.Operations;
    using Processors.DataProviders;

    public class CommandHandler : FrontControllerHandler
    {
        private static readonly IRemotableCreekController RemotableCreekController;

        static CommandHandler()
        {
            string sCreekRemotingUri = ConfigurationManager.AppSettings["CreekRemotingUri"];
            RemotableCreekController = CreekControllerProxy.ProxyFactory(sCreekRemotingUri);
        }

        public CommandHandler() : base(GetProcessors())
        {
        }

        private static IList<IRequestHandler> GetProcessors()
        {
            return new List<IRequestHandler>
               {
                   new ContentDownloaderRequestProcessor(RemotableCreekController),
                   new DefaultRequestHandler(
                       new SingleParamRequestMatcher("cmd", "query-content-list"),
                       new QueryContentListFiller(RemotableCreekController)),
                   new DefaultRequestHandler(
                       new SingleParamRequestMatcher("cmd", "query-seed-list"),
                       new QuerySeedListFiller(RemotableCreekController)),
                   new DefaultRequestHandler(
                       new SingleParamRequestMatcher("cmd", "query-sys-notification"),
                       new QuerySysNotificationFiller(RemotableCreekController)),
                   new DefaultRequestHandler(
                       new SingleParamRequestMatcher("cmd", "query-content-summary"),
                       new QueryContentSummaryFiller(RemotableCreekController)),
                   new DefaultRequestHandler(
                       new SingleParamRequestMatcher("cmd", "query-work-in-progress"),
                       new QueryWorkInProgressFiller(RemotableCreekController)),
                   new DefaultRequestHandler(
                       new SingleParamRequestMatcher("cmd", "query-version-list"),
                       new QueryContentVersionListFiller(RemotableCreekController)),
                   new DefaultRequestHandler(
                       new SingleParamRequestMatcher("cmd", "query-torrent-seed-detail"),
                       new QueryTorrentSeedDetailFiller(RemotableCreekController)),
                   new DefaultRequestHandler(
                       new SingleParamRequestMatcher("cmd", "query-content-recipes"),
                       new QueryContentRecipesJsonFiller(RemotableCreekController)),
                   new DefaultRequestHandler(
                       new SingleParamRequestMatcher("cmd", "content-gen"),
                       new ContentGenFiller(RemotableCreekController)),
                   new DefaultRequestHandler(
                       new SingleParamRequestMatcher("cmd", "interrupt-content-gen"),
                       new InterruptContentGenFiller(RemotableCreekController)),
                   new DefaultRequestHandler(
                       new SingleParamRequestMatcher("cmd", "deploy-content"),
                       new DeployContentFiller(RemotableCreekController)),
                   new DefaultRequestHandler(
                       new SingleParamRequestMatcher("cmd", "content-offline"),
                       new OfflineContentFiller(RemotableCreekController)),
                   new DefaultRequestHandler(
                       new SingleParamRequestMatcher("cmd", "pause-seeds"),
                       new PauseContentFiller(RemotableCreekController)),
                   new DefaultRequestHandler(
                       new SingleParamRequestMatcher("cmd", "resume-seeds"),
                       new ResumeContentFiller(RemotableCreekController)),
                   new DefaultRequestHandler(
                       new SingleParamRequestMatcher("cmd", "query-display-name"),
                       new QueryDisplayNameFiller(RemotableCreekController)),
                   new DefaultRequestHandler(
                       new SingleParamRequestMatcher("cmd", "query-home-url"),
                       new QueryHomeUrlFiller(RemotableCreekController)),
                   new DefaultRequestHandler(
                       new SingleParamRequestMatcher("cmd", "query-online-faq-url"),
                       new QueryOnlineFaqUrlFiller(RemotableCreekController)),
                   new DefaultRequestHandler(
                       new SingleParamRequestMatcher("cmd", "query-icon-file"),
                       new QueryIconFileFiller(RemotableCreekController)),
                   new DefaultRequestHandler(
                       new SingleParamRequestMatcher("cmd", "query-disclaimer-file"),
                       new QueryDisclaimerFileFiller(RemotableCreekController)),
                   new DefaultRequestHandler(
                       new SingleParamRequestMatcher("cmd", "query-ga-profile-id"),
                       new QueryGaProfileIdFiller(RemotableCreekController)),
                   new DefaultRequestHandler(
                       new SingleParamRequestMatcher("cmd", "query-promo-event-id"),
                       new QueryPromoEventIdFiller(RemotableCreekController)),
                   new DefaultRequestHandler(
                       new SingleParamRequestMatcher("cmd", "query-promo-event-server-url"),
                       new QueryPromoEventServerUrlFiller(RemotableCreekController)),
                   new DefaultRequestHandler(
                       new SingleParamRequestMatcher("cmd", "query-default-values"),
                       new QueryDefaultValuesFiller(RemotableCreekController))
               };
        }
    }
}
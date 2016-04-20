using System;
using System.IO;
using System.Web;
using Creek.Jobs;
using Creek.Controller;

namespace CreekPortal.Web.Processors
{
    using FrontController;

    public class ContentDownloaderRequestProcessor : IRequestHandler
    {
        protected readonly IRemotableCreekController _creekController;

        public ContentDownloaderRequestProcessor(IRemotableCreekController creekController)
        {
            _creekController = creekController;
        }

        public bool HandleRequest(HttpContextBase context)
        {
            string contentDisposition;
            var cmd = context.Request.Params["cmd"];
            var content = context.Request.Params["content_id"];
            var version = context.Request.Params["content_hash"];

            if ((string.IsNullOrEmpty(cmd) ||
                string.IsNullOrEmpty(content) ||
                string.IsNullOrEmpty(version)) ||
                cmd != "get-downloader" ||
                cmd != "get-metafile")
            {
                return false;
            }

            if (context.Request.Browser.Browser == "IE" &&
               (context.Request.Browser.Version == "6.0" ||
                context.Request.Browser.Version == "7.0" ||
                context.Request.Browser.Version == "8.0"))
                contentDisposition = "attachment; filename=" + Uri.EscapeDataString(content + ContentGenJob.DownloaderExtension);
            else if (context.Request.Browser.Browser == "Safari")
                contentDisposition = "attachment; filename=" + content + ContentGenJob.DownloaderExtension;
            else
                contentDisposition = "attachment; filename*=UTF-8''" + Uri.EscapeDataString(content + ContentGenJob.DownloaderExtension);
            context.Response.ContentType = GetContentType();
            context.Response.AddHeader("Content-Disposition", contentDisposition);
            switch (cmd)
            {
                case "get-downloader":
                    WriteDownloaderToStream(context.Request, context.Response.OutputStream, content, version);
                    break;
                case "get-metafile":
                    WriteMetafileToStream(context.Request, context.Response.OutputStream, content, version);
                    break;
                default:
                    return false;
            }
            return true;
        }

        private string GetContentType()
        {
            return "application/octet-stream";
        }

        public void WriteDownloaderToStream(HttpRequestBase request, Stream outputStream, string contentUniqueId, string contentHashCode)
        {
            using (var inputStream = File.OpenRead(
                Path.GetDirectoryName(request.PhysicalPath) +
                "\\Downloaders\\" +
                contentUniqueId + "\\" +
                contentHashCode + ContentGenJob.DownloaderExtension))
            {
                var buffer = new byte[Math.Min(inputStream.Length, 4096)];
                var readLength = inputStream.Read(buffer, 0, buffer.Length);

                while (readLength > 0)
                {
                    outputStream.Write(buffer, 0, readLength);
                    readLength = inputStream.Read(buffer, 0, buffer.Length);
                }
            }
        }

        public void WriteMetafileToStream(HttpRequestBase request, Stream outputStream, string contentUniqueId, string contentHashCode)
        {
            using (var inputStream = File.OpenRead(
                Path.GetDirectoryName(request.PhysicalPath) +
                "\\Downloaders\\" +
                contentUniqueId + "\\" +
                contentHashCode + ContentGenJob.TorrentExtension))
            {
                var buffer = new byte[Math.Min(inputStream.Length, 4096)];
                var readLength = inputStream.Read(buffer, 0, buffer.Length);

                while (readLength > 0)
                {
                    outputStream.Write(buffer, 0, readLength);
                    readLength = inputStream.Read(buffer, 0, buffer.Length);
                }
            }
        }
    }
}
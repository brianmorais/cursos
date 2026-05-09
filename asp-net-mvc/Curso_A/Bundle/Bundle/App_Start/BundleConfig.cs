using System.Web;
using System.Web.Optimization;

namespace Bundle
{
    public class BundleConfig
    {
        
        public static void RegisterBundles(BundleCollection bundles)
        {
            //Otimização 
            BundleTable.EnableOptimizations = true;

            //Adicionando bundle
            bundles.Add(new ScriptBundle("~/comum").IncludeDirectory("~/Scripts/comum", "*.js", true));

            //Definindo ordem dos scripts
            var ordem = new BundleFileSetOrdering("meuScript");
            ordem.Files.Add("setup.js");
            ordem.Files.Add("display.js");
            bundles.FileSetOrderList.Insert(0, ordem);

            //Ignorando arquivos
            //bundles.IgnoreList.Ignore("setup.dbg.js");
            bundles.IgnoreList.Ignore("*.dbg.js");








            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                        "~/Scripts/jquery-{version}.js"));

            bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include(
                        "~/Scripts/jquery.validate*"));

            
            
            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                        "~/Scripts/modernizr-*"));

            bundles.Add(new ScriptBundle("~/bundles/bootstrap").Include(
                      "~/Scripts/bootstrap.js"));

            bundles.Add(new StyleBundle("~/Content/css").Include(
                      "~/Content/bootstrap.css",
                      "~/Content/site.css"));
        }
    }
}

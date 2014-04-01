import Hakyll.Core.Configuration (Configuration(..), defaultConfiguration)
import Hakyll.Core.Rules (compile, match, route)
import Hakyll.Core.Routes (idRoute, composeRoutes)
import Hakyll.Core.File (copyFileCompiler)
import Hakyll.Web.Pandoc (pandocCompiler)
import Hakyll.Web.Template (templateCompiler, loadAndApplyTemplate)
import Hakyll.Main (hakyllWith)

import Prefixes (deployedDir)
import Languages (languages)
import Routes ( resourcesPattern, templatesPattern, allPostsPattern, indexPattern
              , noPrefixHTMLRoute, rmDateRoute, postTemplateId, allPagesPattern)
import Contexts (postCtx, defaultTplDefaultCtx, archiveRuleLang)


siteConfig :: Configuration
siteConfig =
    Configuration
        { destinationDirectory = deployedDir ++ "destination"
        , storeDirectory       = deployedDir ++ "store"
        , tmpDirectory         = deployedDir ++ "tmp"
        , providerDirectory    = "site"
        , ignoreFile           = ignoreFile def
        , deployCommand        = deployCommand def
        , deploySite           = deploySite def
        , inMemoryCache        = inMemoryCache def
        , previewPort          = previewPort def
        }
    where def = defaultConfiguration


main :: IO ()
main = hakyllWith siteConfig $ do
    match resourcesPattern $ route idRoute >> compile copyFileCompiler

    match templatesPattern $ compile templateCompiler

    match allPostsPattern $ do
        route $ noPrefixHTMLRoute `composeRoutes` rmDateRoute
        compile $ pandocCompiler
            >>= loadAndApplyTemplate postTemplateId postCtx
            >>= defaultTplDefaultCtx

    match allPagesPattern $ do
        route noPrefixHTMLRoute
        compile $ pandocCompiler >>= defaultTplDefaultCtx

    mapM_ archiveRuleLang languages

    match indexPattern (route idRoute >> compile copyFileCompiler)


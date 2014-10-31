import Data.Set (insert)

import Hakyll.Core.Configuration (Configuration(..), defaultConfiguration)
import Hakyll.Core.Rules (compile, match, route)
import Hakyll.Core.Routes (idRoute, composeRoutes)
import Hakyll.Core.File (copyFileCompiler)
import Text.Pandoc.Options ( ReaderOptions(..), WriterOptions(..)
                           , Extension(..), HTMLMathMethod(MathJax))
import Hakyll.Web.Pandoc ( pandocCompilerWith, defaultHakyllReaderOptions
                         , defaultHakyllWriterOptions )
import Hakyll.Web.Template (templateCompiler, loadAndApplyTemplate)
import Hakyll.Main (hakyllWith)

import Prefixes (deployedDir, mathJaxURL)
import Language (languages)
import Routes ( resourcesPattern, templatesPattern, allPostsPattern, indexPattern
              , noPrefixHTMLRoute, rmDateRoute, postTemplateId, allPagesPattern)
import Contexts (postCtx, defaultTplDefaultCtx, archiveRule)


siteConfig :: Configuration
siteConfig =
    defaultConfiguration {
        destinationDirectory = deployedDir ++ "destination"
      , storeDirectory       = deployedDir ++ "store"
      , tmpDirectory         = deployedDir ++ "tmp"
      , providerDirectory    = "site"
    }


readOpt :: ReaderOptions
readOpt = defaultHakyllReaderOptions { readerColumns = 110 }

writeOpt :: WriterOptions
writeOpt =
    defaultHakyllWriterOptions {
        writerHtml5 = True
      , writerExtensions = foldr insert (writerExtensions defaultHakyllWriterOptions) mathExt
      , writerHTMLMathMethod = MathJax mathJaxURL
      , writerIdentifierPrefix = "id-"
    } where mathExt = [Ext_tex_math_dollars, Ext_tex_math_double_backslash, Ext_latex_macros]


main :: IO ()
main = hakyllWith siteConfig $ do
    match resourcesPattern $ route idRoute >> compile copyFileCompiler

    match templatesPattern $ compile templateCompiler

    match allPostsPattern $ do
        route $ noPrefixHTMLRoute `composeRoutes` rmDateRoute
        compile $ pandocCompilerWith readOpt writeOpt
            >>= loadAndApplyTemplate postTemplateId postCtx
            >>= defaultTplDefaultCtx

    match allPagesPattern $ do
        route noPrefixHTMLRoute
        compile $ pandocCompilerWith readOpt writeOpt >>= defaultTplDefaultCtx

    mapM_ archiveRule languages

    match indexPattern (route idRoute >> compile copyFileCompiler)


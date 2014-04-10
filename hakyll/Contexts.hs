module Contexts where

import Data.Monoid (mappend, mconcat)

import Hakyll.Core.Rules (Rules, match, route, compile)
import Hakyll.Core.Item (Item)
import Hakyll.Core.Compiler (Compiler, loadAll)
import Hakyll.Core.Identifier.Pattern (fromGlob, fromList, fromCapture)
import Hakyll.Web.Template (loadAndApplyTemplate)
import Hakyll.Web.Template.Context (Context, defaultContext, dateField, listField)
import Hakyll.Web.Template.List (recentFirst)
import Hakyll.Web.Pandoc (pandocCompiler)
import Hakyll.Web.Tags (Tags, buildCategories, tagsMap)

import Prefixes (prs)
import Languages (Lang, trCtx)
import Routes (postsPattern, defaultTemplateId, archiveTemplateId, noPrefixHTMLRoute)


defaultTRCtx :: Context String
defaultTRCtx = trCtx `mappend` defaultContext

defaultTplDefaultCtx :: Item String -> Compiler (Item String)
defaultTplDefaultCtx = loadAndApplyTemplate defaultTemplateId defaultTRCtx

postCtx :: Context String
postCtx = dateField "date" "%Y-%m-%d" `mappend` defaultTRCtx


archiveCtx :: Tags -> Context String
archiveCtx cs = mappend defaultTRCtx $
    mconcat [listField c postCtx (recentFirst =<< loadAll (fromList p)) | (c,p) <- tagsMap cs]

archiveRule :: Lang -> Rules ()
archiveRule l = match (fromGlob $ prs ++ show l ++ "/posts.md") $ do
    cs <- buildCategories (postsPattern l) (fromCapture $ categoriesPattern l)
    route $ noPrefixHTMLRoute
    compile $ pandocCompiler
        >>= loadAndApplyTemplate archiveTemplateId (archiveCtx cs)
        >>= defaultTplDefaultCtx


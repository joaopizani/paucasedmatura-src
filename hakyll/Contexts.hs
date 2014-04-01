module Contexts where

import Data.Monoid (mappend)

import Hakyll.Core.Routes (setExtension, composeRoutes)
import Hakyll.Core.Rules (Rules, match, route, compile)
import Hakyll.Core.Item (Item)
import Hakyll.Core.Compiler (Compiler, loadAll)
import Hakyll.Core.Identifier.Pattern (Pattern, fromGlob)
import Hakyll.Web.Template (loadAndApplyTemplate)
import Hakyll.Web.Template.Context (Context, defaultContext, dateField, listField, constField)
import Hakyll.Web.Template.List (recentFirst)
import Hakyll.Web.Pandoc (pandocCompiler)

import Prefixes (prs)
import Languages (Lang, trCtx)
import Routes (postsPattern, defaultTemplateId, archiveTemplateId, rmPrefixRoute)


defaultTRCtx :: Context String
defaultTRCtx = trCtx `mappend` defaultContext

defaultTplDefaultCtx :: Item String -> Compiler (Item String)
defaultTplDefaultCtx = loadAndApplyTemplate defaultTemplateId defaultTRCtx

postCtx :: Context String
postCtx = dateField "date" "%Y-%m-%d" `mappend` defaultTRCtx

archiveCtx :: Pattern -> Context String
archiveCtx p =
    listField "posts" postCtx (recentFirst =<< loadAll p) `mappend`
    constField "title" "Posts"                            `mappend`
    defaultTRCtx

archiveRuleLang :: Lang -> Rules ()
archiveRuleLang l = match (fromGlob $ prs ++ show l ++ "/posts.md") $ do
    route $ rmPrefixRoute `composeRoutes` setExtension "html"
    compile $ pandocCompiler
        >>= loadAndApplyTemplate archiveTemplateId (archiveCtx $ postsPattern l)
        >>= defaultTplDefaultCtx


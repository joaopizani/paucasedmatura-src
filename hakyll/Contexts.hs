module Contexts where

import Prelude hiding (lookup)
import Data.Monoid (mappend, mconcat)
import Data.Map (member, lookup)

import Hakyll.Core.Rules (Rules, match, route, compile)
import Hakyll.Core.Item (Item, itemIdentifier)
import Hakyll.Core.Metadata (getMetadata)
import Hakyll.Core.Compiler (Compiler, loadAll)
import Hakyll.Core.Identifier.Pattern (fromGlob, fromList, fromCapture)
import Hakyll.Web.Template (loadAndApplyTemplate)
import Hakyll.Web.Template.List (recentFirst)
import Hakyll.Web.Pandoc (pandocCompiler)
import Hakyll.Web.Tags (Tags, buildCategories, tagsMap)
import Hakyll.Web.Template.Context ( Context, field, functionField
                                   , defaultContext, dateField, listField)

import Prefixes (prs, mathJaxURL)
import Language (Lang(..), TR(..), itemLang, trMap)
import LanguageTable (translationTable)
import Routes ( postsPattern, defaultTemplateId
              , archiveTemplateId, noPrefixHTMLRoute, categoriesPattern)


trCtx :: Context a
trCtx = functionField "tr" $ \args item -> do
    let l = itemLang item
    k <- getArgs args
    translationRecord <- getVal k (trMap translationTable)
    return $ (selector l) translationRecord
    where
        getArgs as = case as         of { [k]    -> return k;  _ -> fail "fail: trCtx - getArgs"}
        getVal k m = case lookup k m of { Just v -> return v;  _ -> fail "fail: trCtx - getVal"} 
        selector l = case l of {PT -> ptT;  EN -> enT;  DE -> deT}

defaultTRCtx :: Context String
defaultTRCtx = trCtx `mappend` defaultContext

mathCtx :: Context String
mathCtx = field "mathjax" $ \item -> do
    meta <- getMetadata $ itemIdentifier item
    return $ if "mathjax" `member` meta
             then "<script type=\"text/javascript\" src=\"" ++ mathJaxURL ++ "\"></script>"
             else ""

postCtx :: Context String
postCtx = dateField "date" dateFormat `mappend` mathCtx `mappend` defaultTRCtx
    where dateFormat = "%Y-%m-%d" 


defaultTplDefaultCtx :: Item String -> Compiler (Item String)
defaultTplDefaultCtx = loadAndApplyTemplate defaultTemplateId defaultTRCtx


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


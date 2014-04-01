module Routes where

import Data.List (concat)
import System.FilePath (pathSeparator)

import Hakyll.Core.Routes (Routes, composeRoutes, gsubRoute, setExtension)
import Hakyll.Core.Identifier (Identifier, fromFilePath)
import Hakyll.Core.Identifier.Pattern (Pattern, fromGlob, (.||.), fromList)

import Prefixes (prs, prc, prf, prt)
import Languages (Lang(..), languages)


templatesPattern :: Pattern
templatesPattern = fromGlob (prt ++ "*")

resourcesPattern :: Pattern
resourcesPattern = foldr1 (.||.) [fromGlob (p ++ "**") | p <- [prc, prf]]

postsPattern :: Lang -> Pattern
postsPattern l = fromGlob (prs ++ show l ++ "/blog/**.md")

indexPattern :: Pattern
indexPattern = fromGlob ("index.html")

allPostsPattern :: Pattern
allPostsPattern = foldr1 (.||.) [postsPattern l | l <- languages]

pageDirnames :: [String]
pageDirnames = ["bsc", "msc"]

pageNames :: [String]
pageNames = concat [ [lp l p | l <- languages, p <- common], [lp l p | l <- [EN, PT],  p <- en_pt] ]
    where
        lp l p = show l ++ (pathSeparator : p)
        common = ["index", "joaopizani"]
        en_pt  = ["bib", "bsc-overview", "msc-overview", "vhdl-tutorial"]

allPagesPattern :: Pattern
allPagesPattern = level1 .||. level2
    where
        level1 = fromList [fromFilePath (prs ++ p ++ ".md") | p <- pageNames]
        level2 = foldr1 (.||.) [fromGlob (prs ++ "*/" ++ p ++ "/*.md") | p <- pageDirnames]


rmPrefixRoute :: Routes
rmPrefixRoute = gsubRoute prs (const "")

rmDateRoute :: Routes
rmDateRoute = gsubRoute "/[0-9]{4}-[0-9]{2}-[0-9]{2}_" (const "/")

noPrefixHTMLRoute :: Routes
noPrefixHTMLRoute = rmPrefixRoute `composeRoutes` setExtension "html"


defaultTemplateId :: Identifier
defaultTemplateId = fromFilePath (prt ++ "default.html")

postTemplateId :: Identifier
postTemplateId = fromFilePath (prt ++ "post.html")

archiveTemplateId :: Identifier
archiveTemplateId = fromFilePath (prt ++ "archive.html")


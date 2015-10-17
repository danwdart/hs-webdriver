{-# LANGUAGE OverloadedStrings #-}
module Test.Etc.Async where

import Test.WebDriver
import qualified Data.Aeson as A

main :: IO ()
main = runSession defaultConfig $ do
    openPage "http://www.wikipedia.org/"
    r <- asyncJS [] "arguments[0]();"
    if r /= Just A.Null
      then error $ "Async returned " ++ show r
      else return ()

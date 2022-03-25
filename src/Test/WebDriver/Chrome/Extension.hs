{-# LANGUAGE FlexibleContexts           #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
-- |Functions and types for working with Google Chrome extensions.
module Test.WebDriver.Chrome.Extension
       ( ChromeExtension
       , loadExtension
       , loadRawExtension
       ) where
import           Control.Applicative
import           Control.Monad.Base
import           Data.Aeson
import           Data.ByteString.Base64.Lazy as B64
import           Data.ByteString.Lazy        as LBS
import           Data.Text.Lazy
import           Data.Text.Lazy.Encoding     (decodeLatin1)

import           Prelude

-- |An opaque type representing a Google Chrome extension. Values of this type
-- are passed to the 'Test.Webdriver.chromeExtensions' field.
newtype ChromeExtension = ChromeExtension Text
                        deriving (Eq, Show, Read, ToJSON, FromJSON)

-- |Load a .crx file as a 'ChromeExtension'.
loadExtension :: MonadBase IO m => FilePath -> m ChromeExtension
loadExtension path = liftBase $ loadRawExtension <$> LBS.readFile path

-- |Load raw .crx data as a 'ChromeExtension'.
loadRawExtension :: ByteString -> ChromeExtension
loadRawExtension = ChromeExtension . decodeLatin1 . B64.encode

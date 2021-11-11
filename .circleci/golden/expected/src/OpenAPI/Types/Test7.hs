-- CHANGE WITH CAUTION: This is a generated code file generated by https://github.com/Haskell-OpenAPI-Code-Generator/Haskell-OpenAPI-Client-Code-Generator.

{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE MultiWayIf #-}

-- | Contains the types generated from the schema Test7
module OpenAPI.Types.Test7 where

import qualified Prelude as GHC.Integer.Type
import qualified Prelude as GHC.Maybe
import qualified Control.Monad.Fail
import qualified Data.Aeson
import qualified Data.Aeson as Data.Aeson.Encoding.Internal
import qualified Data.Aeson as Data.Aeson.Types
import qualified Data.Aeson as Data.Aeson.Types.FromJSON
import qualified Data.Aeson as Data.Aeson.Types.ToJSON
import qualified Data.Aeson as Data.Aeson.Types.Internal
import qualified Data.ByteString.Char8
import qualified Data.ByteString.Char8 as Data.ByteString.Internal
import qualified Data.Functor
import qualified Data.Scientific
import qualified Data.Text
import qualified Data.Text.Internal
import qualified Data.Time.Calendar as Data.Time.Calendar.Days
import qualified Data.Time.LocalTime as Data.Time.LocalTime.Internal.ZonedTime
import qualified GHC.Base
import qualified GHC.Classes
import qualified GHC.Int
import qualified GHC.Show
import qualified GHC.Types
import qualified OpenAPI.Common
import OpenAPI.TypeAlias

-- | Defines the object schema located at @components.schemas.Test7.items@ in the specification.
-- 
-- 
data Test7Item = Test7Item {
  -- | prop1
  test7ItemProp1 :: (GHC.Maybe.Maybe GHC.Types.Int)
  -- | prop2
  , test7ItemProp2 :: (GHC.Maybe.Maybe Data.Text.Internal.Text)
  } deriving (GHC.Show.Show
  , GHC.Classes.Eq)
instance Data.Aeson.Types.ToJSON.ToJSON Test7Item
    where toJSON obj = Data.Aeson.Types.Internal.object ("prop1" Data.Aeson.Types.ToJSON..= test7ItemProp1 obj : "prop2" Data.Aeson.Types.ToJSON..= test7ItemProp2 obj : GHC.Base.mempty)
          toEncoding obj = Data.Aeson.Encoding.Internal.pairs (("prop1" Data.Aeson.Types.ToJSON..= test7ItemProp1 obj) GHC.Base.<> ("prop2" Data.Aeson.Types.ToJSON..= test7ItemProp2 obj))
instance Data.Aeson.Types.FromJSON.FromJSON Test7Item
    where parseJSON = Data.Aeson.Types.FromJSON.withObject "Test7Item" (\obj -> (GHC.Base.pure Test7Item GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..:? "prop1")) GHC.Base.<*> (obj Data.Aeson.Types.FromJSON..:? "prop2"))
-- | Create a new 'Test7Item' with all required fields.
mkTest7Item :: Test7Item
mkTest7Item = Test7Item{test7ItemProp1 = GHC.Maybe.Nothing,
                        test7ItemProp2 = GHC.Maybe.Nothing}
-- | Defines an alias for the schema located at @components.schemas.Test7@ in the specification.
-- 
-- 
type Test7 = [Test7Item]

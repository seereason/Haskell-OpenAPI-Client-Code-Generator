{-# LANGUAGE OverloadedStrings #-}

import Control.Exception
import Data.Aeson
import Data.Either
import Data.HashMap.Strict (fromList)
import qualified Data.Text as T
import Lib
import Network.HTTP.Client
import Network.HTTP.Simple
import OpenAPI
import Test.Hspec

main :: IO ()
main =
  hspec $ do
    describe "runGetInventory" $
      it "get inventory" $
        do
          response <- runGetInventory
          getResponseBody response
            `shouldBe` GetInventoryResponse200 (fromList [("pet1", Number 23), ("pet2", Number 2)])
    describe "runAddPet" $
      it "add pet" $
        do
          response <- runAddPet
          getResponseBody response `shouldBe` AddPetResponse200
    describe "runFindPetsByStatus" $
      it "find pets by status" $
        do
          response <- runFindPetsByStatus FindPetsByStatusParametersStatusEnumPending
          getResponseBody response
            `shouldBe` FindPetsByStatusResponse200
              [ (mkPet [])
                  { petId = Just 23,
                    petName = Just "Ted",
                    petStatus = Just PetStatusEnumPending
                  }
              ]
    describe "runFindPetsByStatus" $
      it "find pets by status" $
        do
          response <- runFindPetsByStatus $ FindPetsByStatusParametersStatusTyped "notExistingStatus"
          getResponseBody response
            `shouldBe` FindPetsByStatusResponse400

    describe "runEchoUserAgent" $
      it "returns the user agent" $
        do
          response <- runEchoUserAgent
          getResponseBody response
            `shouldSatisfy` ( \body -> case body of
                                EchoUserAgentResponse200 text ->
                                  "XYZ" `T.isInfixOf` text
                                    && "openapi3-code-generator" `T.isInfixOf` text
                                _ -> False
                            )

    describe "runEchoUserAgentWithoutUserAgent" $
      it "should fail as the user agent is not present" $
        do
          response <- runEchoUserAgentWithoutUserAgent
          getResponseBody response
            `shouldBe` EchoUserAgentResponse400

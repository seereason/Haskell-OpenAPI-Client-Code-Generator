{-# LANGUAGE OverloadedStrings #-}

import Control.Monad.Trans.Reader
import Data.ByteString.Char8
import Data.Either
import qualified Data.HashMap.Strict as HashMap
import Lib
import Network.HTTP.Client.Internal
import Network.HTTP.Simple
import Network.HTTP.Types
import OpenAPI
import Test.Hspec
import Test.MonadHTTP

succeededResponse :: Response ByteString
succeededResponse = defaultResponse {responseBody = "{}"}

main :: IO ()
main =
  hspec $ do
    describe "runGetInventory" $ do
      it "should run anonymous" $ do
        let requestExpectation = expectURL "http://localhost:8887/store/inventory" $ expectMethod "GET" noExpectation
        response <- runMock runGetInventoryAnonymous (requestExpectation, succeededResponse)
        getResponseBody response `shouldBe` GetInventoryResponse200 HashMap.empty
      it "should run with basic auth" $ do
        let requestExpectation = expectAuthorization "Basic dXNlcjpwdw==" noExpectation
        response <- runMock runGetInventoryBasicAuth (requestExpectation, succeededResponse)
        getResponseBody response `shouldBe` GetInventoryResponse200 HashMap.empty
      it "should run with bearer auth" $ do
        let requestExpectation = expectAuthorization "Bearer token" noExpectation
        response <- runMock runGetInventoryBearerAuth (requestExpectation, succeededResponse)
        getResponseBody response `shouldBe` GetInventoryResponse200 HashMap.empty
      it "should run multiple requests with bearer auth" $ do
        let requestExpectation = expectAuthorization "Bearer token" noExpectation
        (response1, response2) <- runMock runMultipleRequestsWithBearerAuth (requestExpectation, succeededResponse)
        getResponseBody response1 `shouldBe` GetInventoryResponse200 HashMap.empty
        getResponseBody response2 `shouldBe` AddPetResponse200
    describe "runAddPet" $
      it "should encode Body" $
        do
          let requestExpectation = expectBody "{\"category\":null,\"id\":null,\"name\":\"Harro\",\"photoUrls\":[],\"status\":null,\"tags\":null}" $ expectMethod "POST" noExpectation
          response <- runMock runAddPet (requestExpectation, succeededResponse)
          getResponseBody response `shouldBe` AddPetResponse200
    describe "runGetAllPetsAsOneOf" $
      it "contain different results" $
        do
          let rawResponse = defaultResponse {responseBody = "[1, \"test\", 2]"} :: Response ByteString
          response <- runMock runGetAllPetsAsOneOf (noExpectation, rawResponse)
          getResponseBody response
            `shouldBe` GetAllPetsAsOneOfResponse200
              [ GetAllPetsAsOneOfResponseBody200Double 1,
                GetAllPetsAsOneOfResponseBody200Text "test",
                GetAllPetsAsOneOfResponseBody200Double 2
              ]
    describe "updatePet" $ do
      it "runUpdatePet" $ do
        let requestExpectation = expectBody "{\"photoUrls\":[],\"status\":null,\"category\":null,\"name\":\"Harro\",\"id\":null,\"tags\":null}" $ expectMethod "PUT" noExpectation
        response <- runMock runUpdatePet (requestExpectation, succeededResponse)
        getResponseBody response `shouldBe` UpdatePetResponse200
      it "runUpdatePetWithTag" $ do
        let requestExpectation = expectBody "{\"name\":\"Tag 1\",\"id\":3}" $ expectMethod "PUT" noExpectation
        response <- runMock runUpdatePetWithTag (requestExpectation, succeededResponse)
        getResponseBody response `shouldBe` UpdatePetResponse200

module Main where

import Data.Array
import Data.Maybe
import Prelude
import Data.Maybe (fromMaybe)
import Data.Nullable

type Definition = {
online :: Boolean,
effectiveType :: String,
saveData :: Boolean,
downlink :: Int,
rtt :: Int}

type NetworkPerformance = {
online :: Boolean,
effectiveType :: String,
saveData :: Boolean,
downlink :: Int,
rtt :: Int}

type Result = {
isOnline :: Boolean,
slowEffectiveType :: Boolean,
slowSaveData :: Boolean,
slowDownlink :: Boolean,
slowRtt :: Boolean }

type Predicate = {
online :: (Definition -> NetworkPerformance -> Boolean),
effectiveType :: (Definition -> NetworkPerformance -> Boolean),
saveData :: (Definition -> NetworkPerformance -> Boolean),
downlink :: (Definition -> NetworkPerformance -> Boolean),
rtt :: (Definition -> NetworkPerformance -> Boolean)}

isSlowNetwork :: Definition -> NetworkPerformance -> Boolean
isSlowNetwork def performance = performance # (getResult def) # matchResult

isOnline' :: Definition -> NetworkPerformance -> Boolean
isOnline' def' performance' = (performance'.online == true)

isSlowSaveData' :: Definition -> NetworkPerformance -> Boolean
isSlowSaveData' def' performance' = performance'.saveData == def'.saveData

isSlowDownLink' :: Definition -> NetworkPerformance -> Boolean
isSlowDownLink' def' performance' = performance'.downlink <= def'.downlink

isSlowRtt' :: Definition -> NetworkPerformance -> Boolean
isSlowRtt' def' performance' = performance'.rtt >= def'.rtt

isSlowEffectiveType' :: Definition -> NetworkPerformance -> Boolean
isSlowEffectiveType' def' performance' = (getEffectiveTypeRanking performance'.effectiveType ) <= (getEffectiveTypeRanking def'.effectiveType )
  where
  effectiveTypeList :: Array String
  effectiveTypeList = ["slow-2g", "2g", "3g", "4g"]

  getEffectiveTypeRanking :: String -> Int
  getEffectiveTypeRanking value = (value `elemIndex` effectiveTypeList) # (fromMaybe 0)

getResult :: Definition -> NetworkPerformance -> Result
getResult def performance = {
  isOnline: (isOnline' def performance),
  slowEffectiveType: (isSlowEffectiveType' def performance),
  slowSaveData: (isSlowSaveData' def performance),
  slowDownlink: (isSlowDownLink' def performance),
  slowRtt: (isSlowRtt' def performance)
  }

matchResult :: Result -> Boolean
matchResult { isOnline: false, slowEffectiveType: _, slowSaveData: _, slowDownlink: _, slowRtt: _ } = false
matchResult { isOnline: true, slowEffectiveType: true, slowSaveData: _, slowDownlink: _, slowRtt: _ } = true
matchResult { isOnline: true, slowEffectiveType: _, slowSaveData: true, slowDownlink: _, slowRtt: _ } = true
matchResult { isOnline: true, slowEffectiveType: _, slowSaveData: _, slowDownlink: true, slowRtt: _ } = true
matchResult { isOnline: true, slowEffectiveType: _, slowSaveData: _, slowDownlink: _, slowRtt: true } = true
matchResult { isOnline: true, slowEffectiveType: _, slowSaveData: _, slowDownlink: _, slowRtt: _ } = false

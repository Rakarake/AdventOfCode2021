module Main where

import Lib
import System.Environment
import qualified Day1
import qualified Day2

main :: IO ()
main = do
   args <- getArgs
   let [day, part] = args
   loadDayAndPart day part

loadDayAndPart :: String -> String -> IO ()
loadDayAndPart dayStr partStr
  | day == 1 && part == 1 = Day1.part1
  | day == 1 && part == 2 = Day1.part2
  | day == 2 && part == 1 = Day2.part1
  | day == 2 && part == 2 = Day2.part2
 where
    day :: Int
    day = read dayStr
    part :: Int
    part = read partStr
loadDayAndPart _ _ = error "Haskell: bad args!"


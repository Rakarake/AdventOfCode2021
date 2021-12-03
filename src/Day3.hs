import Data.List

part1 = do
   contents <- readFile "src/day3-input"
   let mostCommonTrues  = mostCommonBits prioritizeTrue $ inputToBitLists contents
   let mostCommonFalses = flipBits mostCommonTrues
   print $ binToDec mostCommonTrues * binToDec mostCommonFalses

part2 = do
   contents <- readFile "src/day3-input"
   let bitLists = inputToBitLists contents
   print $ oxygenGeneratorRating bitLists
   print $ co2ScrubberRating     bitLists
   print (oxygenGeneratorRating bitLists * co2ScrubberRating bitLists)


inputToBitLists :: String -> [[Bool]]
inputToBitLists = map rowToBits . lines

rowToBits :: String -> [Bool]
rowToBits = map charToBit
 where
    charToBit c
      | c == '0'  = False
      | c == '1'  = True
      | otherwise = error "Bit parse error, only 0 and 1 allowed!"

-- Big endian
binToDec :: [Bool] -> Int
binToDec = foldl (\y x -> fromEnum x + 2*y) 0

flipBits :: [Bool] -> [Bool]
flipBits = map not

-- Helpers to make code more readable
prioritizeTrue = True
prioritizeFalse = False

--                prio
mostCommonBits :: Bool -> [[Bool]] -> [Bool]
mostCommonBits prio rows = map trueMostCommon $ map (sum . map fromEnum) (transpose rows)
 where
    trueMostCommon :: Int -> Bool
    trueMostCommon n
      | even (length rows) && (n == (length rows `div` 2)) = prio
      | otherwise                                          = n > length rows `div` 2

-- Part 2 --
--                index  prio      indx   common  return
ogr :: [[Bool]] -> Int -> Bool -> (Bool -> Bool -> Bool) -> Int
ogr [row] _ _    _          = binToDec row
ogr rows  i prio fQualified = ogr (filter qualifiedRow rows) (i + 1) prio fQualified
 where
    mostCommonCurrentBit = mostCommonBits prio rows !! i
    qualifiedRow :: [Bool] -> Bool
    qualifiedRow row = fQualified (row !! i) mostCommonCurrentBit

oxygenGeneratorRating :: [[Bool]] -> Int
oxygenGeneratorRating rows = ogr rows 0 prioritizeTrue (==)

-- idk why it works by putting prioritizeTrue here, too tired of this now
co2ScrubberRating :: [[Bool]] -> Int
co2ScrubberRating rows = ogr rows 0 prioritizeTrue (/=)


testDataBin = map rowToBits testData
testData :: [String]
testData =
 ["00100"
 ,"11110"
 ,"10110"
 ,"10111"
 ,"10101"
 ,"01111"
 ,"00111"
 ,"11100"
 ,"10000"
 ,"11001"
 ,"00010"
 ,"01010"]


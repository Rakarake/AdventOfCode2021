module Day2 where

part1 = do
   putStrLn "Day 2, Part 1: "
   contents <- readFile "src/day2-input"
   let (nHorizontal, nVertical) = parseInputPartA $ lines contents
   putStrLn $ "Horizontal: " ++ show nHorizontal ++ ", Vertical: " ++ show nVertical
   putStrLn $ "Product: " ++ show (nHorizontal * nVertical)

part2 = do
   putStrLn "Day 2, Part 2: "
   contents <- readFile "src/day2-input"
   let (nHorizontal2, nVertical2, nAim) = parseInputPartB $ lines contents
   putStrLn $ "Horizontal: " ++ show nHorizontal2 ++
         ", Vertical: " ++ show nVertical2 ++
         ", Aim: " ++ show nAim
   putStrLn $ "Product: " ++ show (nHorizontal2 * nVertical2)

-- Part A --
--                      horizontal vertical
parseInputPartA :: [String] -> (Int, Int)
parseInputPartA inputs = (sum horizontals, sum verticals)
   where
      (horizontals, verticals) = unzip $ map getValue inputs

getValue :: String -> (Int, Int)
getValue str
  | pre == "forward" = (read num, 0)
  | pre == "up"      = (0,- read num)
  | pre == "down"    = (0, read num)
  | otherwise        = error "Syntax error!"
 where
   [pre, num] = words str

-- Part B --
parseInputPartB :: [String] -> (Int, Int, Int)
parseInputPartB = foldl nextIter (0,0,0)
 where
    --           hor  ver  aim
    nextIter :: (Int, Int, Int) -> String -> (Int, Int, Int)
    nextIter (hor, ver, aim) str = (hor + thisHor, ver + thisVer, aim + thisAim)
       where
          (thisHor, thisAim) = getValue str
          thisVer = (thisAim + aim) * thisHor  -- Is zero when thisHor is zero


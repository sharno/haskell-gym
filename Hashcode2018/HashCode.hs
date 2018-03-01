import Data.List
-- import qualified Data.Vector as V

type Ride = (Int, [Int])

readInput :: String -> [Int]
readInput = map read . words

solve :: [[Int]] -> String
solve = unlines . map (\l -> intercalate " " $ map show $ (length l):l)

-- can optimize this more by calculating earlier arrival to prev ride
isPossibleRide :: Ride -> Ride -> Bool
isPossibleRide (_, [a1, b1, x1, y1, start1, finish1]) (_, [a2, b2, x2, y2, start2, finish2]) =
  start1 + prevTripTime + betweenTrips <= start2 &&
  start1 + prevTripTime + betweenTrips + nextTripTime <= finish2
  where
    prevTripTime = abs(x1 - a1) + abs(y1 - b1)
    betweenTrips = abs(x1 - a2) + abs(y1 - b2)
    nextTripTime = abs(x2 - a2) + abs(y2 - b2)

ridesForCar :: [Ride] -> [Ride] -> [Ride]
ridesForCar [] rides = reverse rides
ridesForCar (ride:rest) [] = ridesForCar rest [ride]
ridesForCar (ride:rest) (prevRide:rides)
  | isPossibleRide prevRide ride = ridesForCar rest (ride:prevRide:rides)
  | otherwise = ridesForCar rest (prevRide:rides)

distributeRides :: Int -> [Ride] -> [[Ride]] -> [[Ride]]
distributeRides 0 _ rides = reverse rides
distributeRides remainingCars remainingRides rides =
  distributeRides (remainingCars-1) (remainingRides \\ newRides) (newRides:rides)
  where
    newRides = ridesForCar remainingRides []

sortF :: [Int] -> Int
sortF [a,b,x,y, _] = abs(x - a) + abs(y - b)
sortF _ = 0

main :: IO ()
main = do
  s <- readFile "d.in"
  let (config:rest) = map readInput $ lines $ s
  let [_, _, fleet, _, _, steps] = config
  let rides = zip [0..] (sortOn sortF rest)
  let solvedRides = distributeRides fleet rides []
  let solution = solve $ map (\rs -> map fst rs) solvedRides
  -- let solution = solve [[2, 2, 3], [2, 5 ,6]]
  writeFile "d_solution.out" solution
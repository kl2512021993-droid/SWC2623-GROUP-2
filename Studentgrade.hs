type Student = (String, String, [Double])

-- dataset
students :: [Student]
students =
    [ ("1", "Leman", [78, 85, 90])
    , ("2", "Wan", [88, 92, 84])
    , ("3", "Ahmad", [70, 75, 72])
    , ("4", "Ali", [95, 90, 93])
    , ("5", "Abu", [60, 65, 58])
    ]

-- Cari average score
average :: [Double] -> Double
average scores = sum scores / fromIntegral (length scores)

-- student punya average
studentAverage :: Student -> (String, String, Double)
studentAverage (studentID, name, scores) =
    (studentID, name, average scores)

-- Return students with average score of 80 or above
highAchievers :: [Student] -> [(String, String, Double)]
highAchievers students =
    filter (\(_, _, avg) -> avg >= 80)
    (map studentAverage students)

-- paling tinggi
-- tierule
topStudent :: [Student] -> (String, String, Double)
topStudent (student:remaining) =
    foldl compareStudent (studentAverage student) (map studentAverage remaining)
    where
        compareStudent current candidate
            | third candidate > third current = candidate
            | otherwise = current

        third (_, _, x) = x

-- Main program
main :: IO ()
main = do
    putStrLn "=== All Students and Their Averages ==="
    mapM_ print (map studentAverage students)

    putStrLn "\n=== High-Achieving Students (Average >= 80) ==="
    mapM_ print (highAchievers students)

    putStrLn "\n=== Top-Performing Student ==="
    print (topStudent students)

    putStrLn "\n=== Normal Test Case ==="
    print (studentAverage ("1", "Leman", [78, 85, 90]))

    putStrLn "\n=== Boundary Test Case (Average = 80) ==="
    print (studentAverage ("6", "Test Student", [80, 80, 80]))

    putStrLn "\n=== Tie Test Case ==="
    print (topStudent
        [ ("4", "Ali", [95, 90, 93])
        , ("6", "Test Student", [95, 90, 93])
        ])
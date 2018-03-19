module Lib
    ( someFunc
    ) where

import System.Environment

someFunc :: IO ()
someFunc = do
    args <- getArgs
    putStrLn $ "Input Numbers: " ++ args !! 0 ++ ", " ++ args !! 1
    let a = read $ args !! 0
        b = read $ args !! 1
    putStrLn $ "Sum: " ++ (show $ a + b)
    putStrLn $ "Difference: " ++ (show $ a - b)
    putStrLn $ "Product: " ++ (show $ a * b)
    putStrLn $ "Quotient: " ++ (show $ a / b)

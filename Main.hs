module Main where
import System.Environment

main :: IO()
main = do
    args <- getArgs
    putStrLn ( "Hello, " ++ args !! 0 ++ " " ++ args !! 1 )

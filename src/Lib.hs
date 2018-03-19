module Lib
    ( someFunc
    ) where

someFunc :: IO ()
someFunc = do
    name <- getLine
    putStrLn name

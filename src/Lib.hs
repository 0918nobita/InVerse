module Lib
    ( someFunc
    ) where

import System.Environment

someFunc :: IO ()
someFunc = do
    args <- getArgs
    putStrLn ( "Hello, " ++ args !! 0 ++ " " ++ args !! 1 )

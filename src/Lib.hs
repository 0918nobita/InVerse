module Lib
    ( someFunc
    ) where

import System.Environment
import Text.ParserCombinators.Parsec hiding (spaces)

-- Parser モナド ( 隠蔽されている「追加情報」は入力ストリーム、バックトラックの記録、first と follow 集合など )
-- oneOf ::  Stream s m Char => [Char] -> ParsecT s u m Char
--     引数で与えられた文字列中のどれか一文字を認識する ( パースされた文字を返す )
symbol :: Parser Char
symbol = oneOf "!#$%&|*+-/:<=>?@^_~"

-- Parsec は letter や digit など、いくつものこまごまとした既成のパーサを提供する

-- symbol パーサを呼び出し、エラーが発生したらそれを処理する関数
-- parse は、パースした結果の値、またはエラーを表す Either データ型を返す
--     Left: エラー, Right: 通常の値
readExpr :: String -> String
readExpr input = case parse symbol "lisp" input of
    Left err -> "No match: " ++ show err
    Right val -> "Found value"

someFunc :: IO ()
someFunc = do
    args <- getArgs
    putStrLn $ readExpr $ args !! 0

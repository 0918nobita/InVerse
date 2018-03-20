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
readExpr input = case parse (spaces >> symbol) "lisp" input of
    Left err -> "No match: " ++ show err
    Right val -> "Found value"

-- どんな数のスペースも認識するパーサ
-- Parse アクション space を Parser アクション skipMany1 に渡して一つ以上のスペースを認識するパーサを作る
spaces :: Parser ()
spaces = skipMany1 space

-- どんな値も保持できるデータ型を定義する
-- LispVal 型変数が持つことができる値の集合を表す
-- 選択肢のそれぞれは、コンストラクタのタグとそのコンストラクタが持つことのできるデータ型を含む

data LispVal = Atom String         -- アトムを示す文字列を格納する
    | List [LispVal]               -- 他の LispVal のリストを保持する ( proper リスト )
    | DottedList [LispVal] LispVal -- Scheme の ( a b . c ) を表す ( improper リスト )
    | Number Integer               -- Haskell の整数を保持する
    | String String                -- Haskell の文字列を保持する
    | Bool Bool                    -- Haskell の真偽値を保持する

someFunc :: IO ()
someFunc = do
    args <- getArgs
    putStrLn $ readExpr $ args !! 0

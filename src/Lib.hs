module Lib
    ( someFunc
    ) where

import Control.Monad
import System.Environment
import Text.ParserCombinators.Parsec hiding (spaces)

-- Parser モナド ( 隠蔽されている「追加情報」は入力ストリーム、バックトラックの記録、first と follow 集合など )
-- oneOf : 引数で与えられた文字列中のどれか一文字を認識する ( パースされた文字を返す )
symbol :: Parser Char
symbol = oneOf "!#$%&|*+-/:<=>?@^_~"

-- Parsec は letter や digit など、いくつものこまごまとした既成のパーサを提供する

-- symbol パーサを呼び出し、エラーが発生したらそれを処理する関数
-- parse は、パースした結果の値、またはエラーを表す Either データ型を返す
--     Left: エラー, Right: 通常の値
readExpr :: String -> String
readExpr input = case parse parseExpr "lisp" input of
    Left err -> "No match: " ++ show err
    Right val -> "Found value ( " ++ show val ++ " )"

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
    deriving (Show)

-- コンストラクタと型は別々の名前空間を持つため、String というコンストラクタと String という型の両方を併存させることが可能
-- 型とコンストラクタタグは常に大文字から始まる

-- これらの型を持つ値を作るパーサ関数をいくつか追加する
-- 文字列は、二重引用符で始まり、それに二重引用符以外の文字が0個以上続き、二重引用符で閉じられる

escape :: Parser String
escape = do
    d <- char '\\'
    c <- oneOf "\\\"0nrvtbf"
    return [d, c]

nonEscape :: Parser Char
nonEscape = noneOf "\\\"\0\n\r\v\t\b\f"

character :: Parser String
character = return <$> nonEscape <|> escape

parseString :: Parser LispVal
parseString = do
    char '"'
    strings <- many character
    char '"'
    return $ String $ concat strings

parseAtom :: Parser LispVal
parseAtom = do
    first <- letter <|> symbol
    rest <- many (letter <|> digit <|> symbol)
    let atom = first:rest
    return $ case atom of
        "#t" -> Bool True
        "#f" -> Bool False
        _    -> Atom atom

-- (>>=) :: Monad m => m a -> (a -> m b) -> m b
-- Number . read :: String -> LispVal
-- many1 digit :: Parser String
parseNumber :: Parser LispVal
-- parseNumber = liftM (Number . read) $ many1 digit

-- parseNumber = Number . read <$> many1 digit

-- parseNumber = do
--     str <- many1 digit
--     return $ (Number . read) $ str

parseNumber = many1 digit >>= return . Number . read

parseExpr :: Parser LispVal
parseExpr = parseAtom <|> parseString <|> parseNumber

someFunc :: IO ()
someFunc = do
    args <- getArgs
    putStrLn $ readExpr $ args !! 0

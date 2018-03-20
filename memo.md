## parse

```haskell
parse :: Stream s Identity t => Parsec s () -> SourceName -> s -> Either ParseError a
```

``parse p filePath input`` runs a parser ``p`` over Identity without user state. The ``filePath`` is only used in error messages and may be the empty string. Returns either a ``ParserError`` ( ``Left`` ) or a value of type a ( ``Right`` ) .

``parse p filePath input`` で、ユーザーステートなしで Identitiy についてパーサ ``p`` を実行します。

# InVerse

新しいプログラミング言語です。  
次のような特徴を持っています。

- 名前の束縛は、使用する部分よりも下に記述する ( トップダウンを強制する )
- 原則として正格評価を行う
- インタプリタを同梱したエディタ上でソースコードを記述し、型レベルプログラミングを支援する「型推論ビジュアライザ」や REPL といった機能を提供する
- 未実装の関数でも、名前と型注釈が記述されていれば型チェックが行われる
- (実験的機能) リアクティブ・プログラミングを言語レベルでサポートする

サンプル１：  
直方体の面積を求める

```
main = f 2 3 4
  f w h d = bottom * d
    bottom = width * height
    height = h
    width = w
```

実行結果：

```
24
```

インデントを 1 つ増やすごとに、ローカル環境が用意される

----

サンプル２：

```
main = a + b
  a = f 2
  b = f 3 4
```

実行結果：

```
infered : a は Int 型
infered : b は Int 型
infered : f 2 は Int 型
infered : f は Int -> Int 型
contradiction : f 3 4 は `f は Int -> Int 型` に矛盾
```

---
サンプル３：

```
main# = 2 + first$
  first$ = race (interval 2000) (interval 3000)
```

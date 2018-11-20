# InVerse

InVerse は、ソースコードを逆さに書けるプログラミング言語です。  
InVerse is a new programming language in which you can write source code upside-down.

ソースコードを入力として与えられると、処理系は最初に上から読んで行きます。  
この際、途中で未定義シンボルが発見されても構文に従っていれば放置し、  
構文から推測される各シンボルの情報 ( 実行できるための条件 ) を蓄積していきます。  
すでに蓄積されている条件と、新たに取り込んだ条件との間に矛盾が生じていればエラーを吐きます。  
一番下の行まで読み終わったとき、未定義シンボルが残っていれば未完成エラーとして報告します。

それでもエラーが発生しなかった場合、処理系はインタプリタとして下から実行して行きます。

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

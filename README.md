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

```
f x
f = println
x = "Hello, world"
```

実行結果：

```
Hello, world
```

----

サンプル２：

```
f x
f a b
```

実行結果：

```
error : 未完成 (f, x, a, b)
	1. f は引数を 2 個以上取る関数
	2. x, a は関数 f の第 1 引数に適合
	3. b は関数 f の第 2 引数の適合
```

----

サンプル３： 

```
f x
```

実行結果：

```
error : 未完成 (f, x)
	1. f は引数を 1 つだけ取る関数
	2. x は関数 f の第 1 引数の型に適合
```

----

サンプル４：

```
println a + b
b = 2
a = '1'
```

実行結果：

※ 中置関数 + の型シグネチャは ``Num a => a -> a -> a``

```
error : 型の不適合
	1. 定数 a の型は Char であり型クラス Num のインスタンスではない
```

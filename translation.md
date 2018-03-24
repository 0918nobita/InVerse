## 6.2.4 Syntax of numerical constants

数値表現の構文については、セクション 7.1.1 で詳しく説明します。数値定数においては重要ではないことに注意してください。

<details><summary>原文</summary>
The syntax of the written representations for numbers is described formally in section 7.1.1. Note that case is not significant in numerical constants.
</details>

数値は、基数接頭辞を使用して2進法、8進法、10進法または16進法で記述することができます。基数接頭辞は、``#b`` (2進法)、``#o`` (8進法)、``#x`` (16進法) です。基数接頭辞がついていない場合、10進数として表現されていると推測されます。

<details><summary>原文</summary>
A number may be written in binary, otcal, decimal, or hexadecimal by the use of a radix prefix. The radix prefixes are <code>#b</code> (binary), <code>#o</code> (octal), and <code>#x</code> (hexadecimal). With no radix prefix, a number is assumed to be expressed in decimal.
</details>

A numerical constant may be specified to be either exact or inexact by a prefix. The prefixes are ``#e`` for exact, and ``#i`` for inexact. An exactness prefix may appear before or after any radix prefix that is used. If the written representation of a number has no exactness prefix, the constant may be either inexact or exact. It is inexact if it contains a decimal point, an exponent, or a ``#" character in the place of a digit, otherwise it is exact. In systems with inexact numbers of varying precisions it may be useful to specify the precision of a constant. For this purpose, numerical constants may be written with an exponent marker that indicates the desired precision of the inexact representation.

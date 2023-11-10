# Make dune project

```
dune init proj lam_cal
```

```
$ dune build

$ dune exec lam_cal
Hello, World!
```

# compile

```
$ menhir parser.mly 

$ ocamllex lexer.mll 
10 states, 332 transitions, table size 1388 bytes

$ ocamlc syntax.ml parser.mli parser.ml lexer.ml interpret.ml -o interpret
File "parser.ml", line 271, characters 32-35:
271 |       let _v = _menhir_action_1 var in
                                      ^^^
Error: This expression has type unit but an expression was expected of type
         Syntax.var = string
```

# 06

```
$ menhir parser.mly ; ocamllex lexer.mll ; ocamlc syntax.ml parser.mli parser.ml lexer.ml interpret.ml -o interpret
10 states, 332 transitions, table size 1388 bytes
File "parser.mly", line 31, characters 62-65:
Error: This expression has type float -> float
       but an expression was expected of type Syntax.exp
```

でエラーが出ていた原因は parser.mly の下記の内容にあった。

```
let abstraction :=
  | BACKSLASH; var = ATOM; DOT; ~ = abstraction; { Abst (var, exp) }
  | LAMBDA; var = ATOM; DOT; ~ = abstraction; { Abst (var, exp) }
  | ~ = application; <>
```

exp はこのスコープにおいて存在しないはずだが、float であると認識され、型エラーになっている。syntax.ml の `Abst (var, exp)` に match するように書く必要があるが、勘違いして parser.mly でも `Abst (var, exp)` と書いてしまった。構文解析の結果、abstraction が exp 型の変数になるので、abstruction を与えるのが正しい。

```
let abstraction :=
  | BACKSLASH; var = ATOM; DOT; ~ = abstraction; { Abst (var, abstraction) }
  | LAMBDA; var = ATOM; DOT; ~ = abstraction; { Abst (var, abstraction) }
  | ~ = application; <>
```

修正後、必要なファイルをコンパイルすると、プログラムが実行可能になった。

```
$ menhir parser.mly ; ocamllex lexer.mll ; ocamlc syntax.ml parser.mli parser.ml lexer.ml interpret.ml -o interpret
10 states, 332 transitions, table size 1388 bytes

$ ./interpret 
```

下記が具体的な実行結果になる。

```
\x.x
→ (λx.x)

\x.\y.xy
→ (λx.(λy.xy))a b
→ (λy.xy) b
→ xy

\x.\y.x y
(\x.\y.x y)
Fatal error: exception Failure("lexing: empty token")

\x.\y.aa
→ (λx.(λy.aa))
```

受け入れ可能だが不適切な入力が存在することが分かる。また、$\lambda$ 関数として受け入れ可能であるべき内容だがエラーになる入力もある。


- [新装版 プログラミング言語の基礎理論 - 共立出版](https://www.kyoritsu-pub.co.jp/book/b10003190.html)

```
🤔               \x.x
😊 (λx.x)
🤔 \x.\y. x y
😊 (λx.(λy.(x y)))
🤔 \x .x   
Fatal error: exception Parser.MenhirBasics.Error
🤔 \x.x x
😊 (λx.(x x))
🤔 \x. \y. x y
😊 (λx.(λy.(x y)))
```

- ベータ短縮
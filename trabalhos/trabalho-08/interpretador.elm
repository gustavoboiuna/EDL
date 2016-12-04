import Html exposing (text)

type alias Env = (String -> Int)
zero : Env
zero = \ask -> 0

type Exp = Inteiro Int
         | Var String
         | Add Exp Exp
         | Mult Exp Exp
         | Div Exp Exp

type Prog = Attr String Exp
          | Seq Prog Prog

evalExp : Exp -> Env -> Int
evalExp exp env =
    case exp of
        Inteiro num    -> num
        Var var        -> (env var)
        Add exp1 exp2  -> (evalExp exp1 env) + (evalExp exp2 env)
        Mult exp1 exp2 -> (evalExp exp1 env) * (evalExp exp2 env)
        Div exp1 exp2  -> (evalExp exp1 env) // (evalExp exp2 env)

evalProg : Prog -> Env -> Env
evalProg s env =
    case s of
        Seq s1 s2 ->
            (evalProg s2 (evalProg s1 env))
        Attr var exp ->
            let
                val = (evalExp exp env)
            in
                \ask -> if ask==var then val else (env ask)

lang : Prog -> Int
lang p = ((evalProg p zero) "ret")

p1 : Prog
p1 = (Attr "ret" (Add (Inteiro 10) (Inteiro 9)))

p2 : Prog
p2 = Seq
        (Attr "x"   (Inteiro 11))
        (Attr "ret" (Add (Var "x") (Inteiro 9)))

main = text (toString (lang p1))

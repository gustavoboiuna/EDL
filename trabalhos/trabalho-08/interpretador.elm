import Html exposing (text)

type alias Env = (String -> Int)
zero : Env
zero = \ask -> 0

type Exp = Inteiro Int
         | Var String
         | Add Exp Exp
         | Sub Exp Exp
         | Mult Exp Exp
         | Div Exp Exp

type Prog = Attr String Exp
          | Seq Prog Prog
          | If Exp Prog Prog
          | While Exp Prog

evalExp : Exp -> Env -> Int
evalExp exp env =
    case exp of
        Inteiro num    -> num
        Var var        -> (env var)
        Add exp1 exp2  -> (evalExp exp1 env) + (evalExp exp2 env)
        Sub exp1 exp2  -> (evalExp exp1 env) - (evalExp exp2 env)
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
                \ask -> if ask == var then val else (env ask)
        If exp prog1 prog2 ->
            if (evalExp exp env) /= 0 then
              (evalProg prog1 env)
            else
              (evalProg prog2 env)
        While exp prog ->
            if (evalExp exp env) /= 0 then
              (evalProg (While exp prog) (evalProg prog env))
            else
              env

lang : Prog -> Int
lang p = ((evalProg p zero) "ret")

p1: Prog
p1 = Seq
          (Attr "x" (Sub (Inteiro 8) (Inteiro 11)))
          (If (Var "x")
              (Attr "ret" (Var "x"))
              (Attr "ret" (Inteiro 100)))

p2 : Prog
p2 = Seq
        (Attr "i" (Inteiro 10))
        (While (Var "i")
          (Seq
            (Attr "ret" (Add (Var "ret") (Inteiro 2)))
            (Attr "i" (Sub (Var "i") (Inteiro 1)))))

p3 : Prog
p3 = Seq
        (Attr "x"   (Inteiro 11))
        (Attr "ret" (Add (Var "x") (Inteiro 9)))

main = text (toString (lang p2))

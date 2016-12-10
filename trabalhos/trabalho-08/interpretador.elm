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
         | Mod Exp Exp
         | E Exp Exp
         | Gt Exp Exp
         | Lt Exp Exp
         | Eq Exp Exp
         | And Exp Exp
         | Or Exp Exp
         | Xor Exp Exp
         | Not Exp

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
        Mod exp1 exp2  -> (evalExp exp1 env) % (evalExp exp2 env)
        E exp1 exp2    -> (evalExp exp1 env) ^ (evalExp exp2 env)
        Gt exp1 exp2   ->
            if (evalExp exp1 env) > (evalExp exp2 env) then
                1
            else
                0
        Lt exp1 exp2   ->
            if (evalExp exp1 env) < (evalExp exp2 env) then
                1
            else
                0
        Eq exp1 exp2   ->
            if (evalExp exp1 env) == (evalExp exp2 env) then
                1
            else
                0
        And exp1 exp2  ->
            if (evalExp exp1 env) /= 0 && (evalExp exp2 env) /= 0 then
                1
            else
                0
        Or exp1 exp2   ->
            if (evalExp exp1 env) /= 0 || (evalExp exp2 env) /= 0 then
                1
            else
                0
        Xor exp1 exp2  ->
            if xor ((evalExp exp1 env) /= 0) ((evalExp exp2 env) /= 0) then
                1
            else
                0
        Not exp        ->
            if (evalExp exp env) /= 0 then
                0
            else
                1

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
        (Attr "i" (Inteiro 20))
        (While (Gt (Var "i") (Inteiro 0))
          (Seq
            (Attr "ret" (Add (Var "ret") (Inteiro 2)))
            (Attr "i" (Sub (Var "i") (Inteiro 1)))))

p3 : Prog
p3 = Seq
        (Seq
          (Attr "x" (Mult (Inteiro 10) (Inteiro 5)))
          (Attr "y" (Div (Inteiro 24) (Inteiro 2))))
        (Attr "ret" (Add (Var "x") (Var "y")))

p4 : Prog
p4 = If (Gt (Inteiro 10) (Inteiro 20))
            (Attr "ret" (Inteiro 10))
            (Attr "ret" (Inteiro 20))

p5 : Prog
p5 = Seq
        (If (Lt (Inteiro 30) (Inteiro 20))
            (Attr "x" (Inteiro 10))
            (Attr "x" (Inteiro 20)))
        (If (Eq (Var "x") (Inteiro 10))
            (Attr "ret" (Mult (Var "x") (Inteiro 2)))
            (Attr "ret" (Div (Var "x") (Inteiro 2))))

p6 : Prog
p6 = Seq
        (Seq
            (Attr "x" (Inteiro 5))
            (Attr "y" (Inteiro 27)))
        (If (And (Eq (Mod (Var "x") (Inteiro 2)) (Inteiro 0)) (Gt (Var "y") (Var "x")))
            (Attr "ret" (Add (Var "x") (Var "y")))
            (Attr "ret" (E (Var "x") (Inteiro 2))))

p7 : Prog
p7 = Seq
        (Seq
            (Attr "x" (Inteiro 21))
            (Attr "y" (Inteiro 9)))
        (If (Or (Eq (Mod (Var "x") (Inteiro 7)) (Inteiro 0)) (Gt (Var "y") (Var "x")))
            (Attr "ret" (Add (Var "x") (Var "y")))
            (Attr "ret" (E (Var "x") (Inteiro 2))))

p8 : Prog
p8 = Seq
        (Seq
            (Attr "x" (Inteiro 21))
            (Attr "y" (Inteiro 10)))
        (If (Not (Lt (Var "x") (Var "y")))
            (Attr "ret" (Sub (Var "x") (Var "y")))
            (Attr "ret" (Mult (Var "x") (Var "y"))))

main = text (toString (lang p8))

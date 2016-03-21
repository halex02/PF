import Parser

type Nom = String

data Expression = Lam Nom Expression
                | App Expression Expression
                | Var Nom
                | Lit Litteral
                deriving (Show,Eq)

data Litteral = Entier Integer
              | Bool   Bool
              deriving (Show,Eq)

data ValeurA = VLitteralA Litteral
             | VFonctionA (ValeurA -> ValeurA)

type Environnement a = [(Nom, a)]

instance Show ValeurA where
    
    show (VFonctionA _) = "λ"                      
    show (VLitteralA (Entier n)) = show n
    show (VLitteralA (Bool b)) = show b

espacesP :: Parser ()
espacesP = zeroOuPlus (car ' ') >>= \_ -> reussit ()

isLetter :: Char -> Bool
isLetter c = elem c ['a'..'z']

nomP :: Parser Nom
nomP = unOuPlus (carCond isLetter) >>= \a -> espacesP >>= \_ -> reussit a

varP :: Parser Expression
varP = nomP >>= \v -> espacesP >>= \_ -> reussit (Var v)

applique :: [Expression] -> Expression
applique [e] = e 
applique xs = App (applique (reverse ys)) y
    where (y:ys) = reverse xs

exprP :: Parser Expression
exprP = exprParentheseeP ||| lambdaP ||| varP ||| nombreP ||| booleenP

exprsP :: Parser Expression
exprsP = unOuPlus exprP >>= \toto -> reussit (applique toto)

lambdaP :: Parser Expression
lambdaP = chaine "\\" >>= \_ -> espacesP >>= \_ -> nomP >>= \x -> chaine "->" >>= \_ -> espacesP >>= \_ -> exprsP >>= \a -> reussit(Lam x a)

exprParentheseeP :: Parser Expression
exprParentheseeP = chaine "(" >>= \_ -> exprsP >>= \x -> chaine ")" >>= \_ -> espacesP >>= \_ -> reussit x

nombreP :: Parser Expression
nombreP = unOuPlus (carCond isChiffre) >>= \x -> espacesP >>= \_ -> reussit(Lit (Entier (read x)))

isChiffre :: Char -> Bool
isChiffre c = elem c ['0'..'9']

booleenP :: Parser Expression
booleenP = chaine "True" ||| chaine "False" >>= \x -> espacesP >>= \_ -> reussit(Lit (Bool (read x)))


expressionP :: Parser Expression
expressionP = espacesP >>= \_ -> exprsP >>= \a -> reussit a

ras :: String -> Expression
ras s | complet expr = resultat expr         
      | otherwise = error "Erreur d’analyse syntaxique"
        where expr = runParser expressionP s


   





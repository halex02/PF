module Lsys where

type Symbole  = Char
type Mot      = [Symbole]
type Axiome   = Mot
type Regles   = Symbole -> Mot
type LSysteme = [Mot]

motSuivant :: Regles -> Mot -> Mot
motSuivant r ms = map r ms

motSuivant' :: Regles -> Mot -> Mot
motSuivant' r (s:[]) = r s
motSuivant' r (s:ms) = (r s)++(motSuivant' r ms)

motSuivant'' :: Regles -> Mot -> Mot
motSuivant'' r ms = concat [r s|s <-ms ]

floconDeVonKoch 'F' = "F−F++F−F"
floconDeVonKoch '+' = "+"
floconDeVonKoch '-' = "-"

lsysteme :: Axiome -> Regles -> LSysteme
lsysteme a r = 

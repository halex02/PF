# Cours 2 : 5 Janvier 2016
^
#Haskell : les bases :

Haskell est fortement typé statiquement.

* Un _type_ est un ensemble de valeurs.
* _Statiquement_ signifie que les types sont vérifiés à la compilation.
* Un typage _fort_ signifie qu'il n'y aura pas d'erreur à l'exécution.

Il y a des types absolument partour en Haskell et on a besoin de les mentionner nul part, car non seulement le compilateur vérifie les types, mais il sait aussi faire _l'inférence des types_ (ie. détection/reconnaissance automatique des types).

## Les types :

* `Bool` : `True` et `False`
* `Char` : type des caractères
* `Int` : nombre entier qui tient dans un mot processeur (valeur max : 9223372036854775807)
* `Integer` : nombre entier non borné (ie. entier en précision arbitraire)
* /!\ Notation particulière pour les types de liste : `[a]` -> type des liste de contenu de type `a`
* `String` : `[Char]`
* Combinaison de type (ie. n-uplets) : `(t1,t2,...,tn)`. Ex : `(Char,Int)`

type.hs:

~~~
-- addition décurryfié
add :: (Int,Int) -> Int
add (x, y) = x + y

zeroTo :: Integer -> [Integer]
zeroTo n = [0..n]

-- duplique :: Int -> (Int, Int)
duplique :: a -> (a, a)
duplique n  = (n, n)

-- addition curryfiée
add' :: Int -> Int -> Int
add' x y = x + y
~~~
{: .language-haskell}

## Curryfication :
^
`add' 1 2` <=> `(add' 1) 2` <=> `add (1, 2)`

## Polymorphisme :
^
Comme en Caml : polymorphisme paramétrique (ie. les Generics en Java).

## SURCHARGE : _"CLASSES"_ de types (warning pas java)
^
`info Num` dans l'interpréteur pour un exemple.  
Classes communes : `Num`, `Eq`, `Ord`, `Show`.

mystere.hs :

~~~
module Mystere where

import Data.List (sort)
import Test.QuickCheck

myst :: Ord a  => [a] -> a
myst [] = []
myst (x:xs) = myst ys ++ (x:ws) ++ myst zs
     where ys = [y | y <- xs, y < x]
     	   zs = [z | z <- xs, z > x]
	   ws = [w | w <- xs, w == x]

propriete xs = myst xs == sort xs
propriete' (1:xs) = True
~~~
{: .language-haskell}
module TP01 where

--Question 3 :
sommeDeXaY x y
  | x <= y    = x + sommeDeXaY (x+1) y
  | otherwise = 0
                
--Question 4 :
somme :: [Int] -> Int
somme [] = 0
somme (x:xs) = x + somme xs

--Question 5 :
myLast [] = error "liste vide"
myLast xs
  | tail xs == [] = head xs
  | otherwise    = myLast (tail xs)

myInit [] = error "liste vide"
myInit xs  = reverse (tail (reverse xs))

--Question 6 :
getter (x:xs) 0  = x
getter (x:xs) i  = getter xs (i-1)
getter []     _  = error "getter : liste vide"

append []     []     = []
append []     ys     = ys
append xs     []     = xs
append (x:xs) ys     = (x:(append xs ys))

myConcat []     = []
myConcat (x:xs) = append x (myConcat xs)
 
myMap f []     = []
myMap f (x:xs) = ((f x):(myMap f xs))

--Question 7 :
-- c'est une application partielle de la fonction (!!).
-- cela représente la définition d'une fonction x de type Integer -> a
-- qui renverra l'élément de l contenu à l'indice passé en paramètre de x.

--Question 8 :
longueur [] = somme [0]
longueur xs = somme (map (\x -> 1) xs)
 
--Question 9 :
maFonctionRec f x 0 = [x]
maFonctionRec f x n = x:(map f (maFonctionRec f x (n-1)))

maFonction f x n = take n (iterate f x)

--Question 10 :
entiersConsecutifs n = maFonction (\x -> x+1) 0 n
                        

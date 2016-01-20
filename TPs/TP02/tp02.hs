--Houplon Alexandre & Toulouse Damien
module TP02 where

--Echauffement :
--Question 1 :
alterne []     = []
alterne [x]    = [x]
alterne (x:xs) = x:(alterne (tail xs))

--Question 2 :
combine f []     _      = []
combine f _      []     = []
combine f (x:xs) (y:ys) = (f x y):(combine f xs ys)

--Triangle de Pascal :
--Question 3 :
pasPascal :: [Integer] -> [Integer]
pasPascal [1] = [1,1]
pasPascal xs  = (zipWith (+) xs (0:xs)) ++ [1] 

--Question 4 :
pascal = iterate pasPascal [1]

--Courbe du dragon :
--Voir fichier dragon.hs et dragon2.hs

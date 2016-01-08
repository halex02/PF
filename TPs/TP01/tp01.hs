module TP01 where

--Question 3 :
sommeDeXaY x y
  | x <= y    = x + sommeDeXaY (x+1) y
  | otherwise = 0

--Question 4 :
somme :: [Int] -> Int
somme [] = 0
somme (x:l) = x + somme l

--Question 5 :
myLast [] = error "liste vide"
myLast l
  | tail l == [] = head l
  | otherwise    = myLast (tail l)

myInit [] = error "liste vide"
myInit l  = reverse (tail (reverse l))

--Question 6 :
getter l i
  | i < 0         = error "index negatif"
  | length l <= i = error "liste trop courte"
  | i == 0        = head l
  | otherwise     = getter (tail l) (i-1)


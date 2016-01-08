# I. Premier contact : quelques défintions et types
^
## I.1. Définitions de fonctions
^
Question 1 :  
Elle peut être du type `(Integer,Integer) -> Integer` ou `Integer -> Integer -> Integer`.  
Algorithme de la fonctionne somme :
~~~
sommeDeXaY (x,y) :
  si x <= y :
    x + sommeDeXaY(x+1,y)
  sinon
    0
~~~
{: .language-pseudocode}

~~~
--forme décurryfiée
sommeDeXaY1 :: (Integer,Integer) -> Integer
sommeDeXaY1 (x,y) =
  if x <= then
    x + sommeDeXaY1(x+1,y)
  else
    0

sommeDeXaY2 (x,y)
  | x <= y    = x + SommeDeXaY2(x+1,y)
  | otherwise = 0
~~~

Comme on ne précise pas le type explicitement pour `sommeDeXaY2`, Haskell l'infère :
~~~
:t sommeDeXaY2
(Ord a, Num a) => (a,a) -> a
~~~
{: .language-haskell}

La fonction `sommeDeXaY2` peut donc s'appliquer sur tous les nombres qui sont comparables (ie. qu'on peut ordonner), pas seulement les entiers. Alors que la fonction `sommeDeXaY1` ne peut prendre que des `Integer` vu qu'on le lui a spécifiquement indiqué.

~~~
--forme curryfiée
sommeDeXaY3 :: (Num a, Ord a) => a -> a -> a
sommeDeXaY3 x y
  | x <= y    = x + sommeDeXaY3 (x+1) y
  | otherwise =
~~~
{: .language-haskell}

application partielle : `(let) f = sommeDeXaY3 1`. Si on applique `f 4` on obtient 10.

~~~
sommeDeXaY4 x y = sum [x..y]
~~~
{: .language-haskell}

Question 2 :
~~~
sum :: Num a => [a] -> a

sum 1 xs =
  if length xs == 0 then
    0
  else
    sum1 (tail xs) + head xs

sum2 [] = 0
sum2 (x:xs) = x + sum2 xs
~~~
{: .language-haskell}

Question 3 :
~~~
prod1 [] = 1
prod1 (x:xs) = x * prod1 xs
~~~
{: .language-haskell}

***
~~~
general op neutre []     = neutre
general op neutre (x:xs) = op x (general op neutre xs)

sum3  = general (+) 0
prod2 = general (*) 1 
~~~
{: .language-haskell}

Tous les opérateurs peuvent s'utiliser comme des fonctions avec la notations (op) : (+), (-), (*), (/).
***

## I.2. Types d'expressions 
^
Question 4 :

* ['a', 'b', 'c'] : [Char]
* [(False, '0'), (True, '1')] : [(Bool, Char)]
* ([False, True], ['0', '1']) : ([Bool], [Char])
* (['a', 'b'], 'c') : ([Char], Char)
* [tail, init, reverse] : [[a]->[a]]
* take 5 : [a]->[a]

* ('a', 'b', 'c') : (Char)
* ([False, '0'], [True, '1']) : non typable
* ([False, True], ['0', '1'])  : non typable
* (['a', 'b'], 'c') : non typable
* [tail, init, reverse] : [[a]->[a]]
* take 5 : [a]->[a]
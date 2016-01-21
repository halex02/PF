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

Question 5 :
Second :: [a] -> a
swap :: (a, b) -> (b, a)
pair :: x -> y -> (x, y)
fst :: (a, b) -> a
double :: Num a => a -> a
palindrome :: [Eq a] -> Bool
twice :: (a -> a) -> a -> a

 /!\ Les fonctions ne sont pas comparables, ie aucun programme ne peut tester l'égalité de deux autres programmes.


L'algorithme d'unification en prolog et l'algorithme de calcul de type de haskell sont très proches.

##I.3 Formes curryfiée et décurryfiée d'une fonction :
^
Question 6 :

~~~
curryfie :: ((t1,t2) -> t) -> t1 -> t2 -> t
curryfie f a b = f (a, b)

curryfie' f =  \a -> \b -> f (a,b)
~~~
{: .language-haskell}

Question 7 :

~~~
decurryfie :: (t1 -> t2 -> t) -> (t1, t2) -> t
decurryfie f (a, b) = f a b

decurryfie' f = \(a, b) -> f a b
~~~
{: .language -haskell}

##I.4 Un itérateur :
^
Question 8 :

~~~
itere :: (t -> t) -> Int -> t -> t
itere f 0 x = x
itere f n x | n < 0     = error "itere : on n'itere pas -n fois !!!"
      	    | otherwise = itere f (n-1) (f x)
~~~
{: .language-haskell}

##I.5 Expressions fonctionnelles numériques :
^
Question 9 :

~~~
sommeCarre :: Num a => a -> a -> a
sommeCarre a b = a^2 + b^2

(Num a, Num a1) => (a1 -> a) -> a
f f' = (f' 2) * 2

f4 a b c =  (a+b+c) + 2

f5 x f = f x (+x)

f6 f x = f x +x

f7 f = (f 1 2) + (f 1 2)
~~~
{: .language-haskell}

##I.6 Expresssions fonctionnelles polymorphes
^
Question 10 :

f1 :: t -> t
f1 x = x
f1 = id --élément neutre dans la composition des fonctions

Num a =>  t -> a
f2 t = 1

Eq a => a -> a -> Bool
f3 x y = x >= y

(t1 -> t) -> t1 -> t
f4 f x = f x

(t2 -> t1) -> (t1 -> t) -> t2 -> t
f5 f g = g (f x)

Eq a => (t -> a) -> (t1 -> a) -> t -> t1 -> Bool
f6  f g x y = f x >= g y

(Eq a, Num a1, Num a2) => (a -> a2 -> a1) -> a -> a -> a1
f7 f a b
   | a == b = (f a 2)+1
   | otherwise = (f b 2)+1

(t2 -> t1 -> t) -> (t2 -> t1) -> t2 -> t
f8 f h x = f x (h x)

t -> t1
f9 x = f9 x

##I.7 Typage d'expressions fonctionnnelles polymorphes
^
Question 11 :

h1 f x y = f x y
h1 :: (a -> b -> c) -> a -> b -> c

h2 f x y = (f x) y
h2 :: (a -> b -> c) -> a -> b -> c

h3 f x y = f (x y)
h3 :: (t2 -> t3)-> (t1 -> t2)-> t1 -> t3

h4 f x y = f(x y f)

#II Quelques fonctions
##II.1 Retour sur le tp1, encore des listes et de la récursivité...
^
myLast (x:_:[]) = x
myLast (_:y:xs) = myLast(y:xs)
myLast _ = error"..."

myCompress :: Eq a => [a] -> [a]


myCompress []         = []
myCompress [x]        = [x]
myCompress (x:y:xs)
	   |x == y    = mycompress (y:xs)
	   |otherwise = x:(mycompress (y:xs))

Question 17
6
3
6
1
1

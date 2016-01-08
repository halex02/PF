# Cours 1 : 5 Janvier 2016
^
# Introduction à la programmation fonctionnelle :

La programmation fonctionnelle est un paradigme, une façon de programmer, une façon de faire/penser les choses.
Langage de programmation purement fonctionnelle : Haskell.

Idée importante dans la programmation fonctionnelle : Il s'agit de la notion de _fonction_. (fonctions d'ordre n)

En programmation impérative, on réfléchit en termes d'états, de buts. On écrit des instructions qui changent cet/ces état(s).  
En programmation fonctionnelle, on oublie tout ça. Il n'y a plus d'états, mais des valeurs.

variable = nom + valeur

On peut penser un programme complet comme une énorme expression qui calcule une valeur.

La programmation fonctionnelle simplifie beaucoup de choses : on peut laisser le compilateur faire beaucoup de choses pour nous. Pourquoi ? Pour éviter de s'arracher les cheveux avec les threads, la répartion des tâches...

## La pureté :
^
L'élément essentiel à avoir en tête : la _pureté_. Quand est-ce-qu'on parle de pureté ? Quand il n'y a pas d'effet de bord (ie. effet secondaire, en général c'est ce qu'on n'aime pas dans les médicaments.).  
Cela permet certes de patcher rapidement un bug, mais ça laisse des codes dégueulasses traîner pendant des années. Cela génère beaucoup de problèmes de maintenance des programmes.

## La transparence référentielle :
^
C'est un aspect particulier de la pureté. Cela signifie qu'une expression peut toujours être remplacée par sa valeur.  
C'est un aspect qui aide beaucoup à la maintenance, notamment dans les tests.

## Parallelisme/Concurrence :
<???>

## Langage applicatif :
^
On parle parfois de langage applicatif. Qu'est-ce-que c'est ? C'est un langage où l'élément central est l'application d'une fonction à un argument.  
On trouve beaucoup de langages à la fois fonctionnels et applicatifs.

## Langage déclaratif :
^
On décrit le résultat (comment l'atteindre) et on laisse la machine faire le travail.

***

# Entrons dans les choses concrètes :
^
Il y a plein de langages fonctionnels, ça existe depuis la nuit des temps.
^
* Le premier langage fonctionnel est LISP (1958). Usage très particulier, langage éloigné de la machine, assez lent.
* Il y a la famille des langages ML (1980) (_Ocaml Power !_). Les ML sont des langages hybrides (fonctionnels et impératifs, LISP aussi d'ailleurs).
* Le langage ERLANG.
* Des langages fonctionnels tournent sous la JVM : SCALA (fonctionnel et orienté objet), CLOJURE (fils spirituel de LISP, au moins au niveau de la syntaxe).
* Bien sûr, il y a Haskell qu'on va utiliser dans ce cours.

## Haskell, c'est quoi ?
^
C'est _LA_ référence des langages purement fonctionnels. C'est un langage élégant et pratique. Il permet de faire des programmes extrêmement concis.  
Autre raison du choix de ce langage pour ce cours :  il est très dur à apprendre tout seul.  
La syntaxe est proche de celle des langages ML, il a un système d'évaluation paresseuse.
C'est un langage amusant à utiliser, les plus beaux programmes sont écrits par des gens qui connaissent Haskell, mais pas forcément en Haskell ! (avis personnel du prof).

## Comment gérer la complexité ?
^
<???>

## Autres langages permettant de faire du fonctionnel :
^
* Java (de plus en plus)
* Javascript

## Programme de calcul de la somme des éléments de 1 à n en C et en Haskell :
^
somme.c :  

~~~
int somme(int n){
    int i , somme  = 0 ;

    for(i = 0 ; i < n ; i++){
    	  somme+=i ;
    }

    return 0 ;
}

~~~
{: .language-c}

somme.hs :  

~~~
somme n = sum [1..n]

somme' n = sum (enumFromTo 1 n)

sommePairs n = sum [0,2..n]

sommeImpairs n = sum [1,3..n]

sommeCarres n = sum (map (^2) [1..n])
~~~
{: .language-haskell}

Somme.java :

~~~
import java.util.stream.*;

public class Somme {
       public static void main (String args[]) {
       	      System.out.println(IntStream.range(1,10).sum());
	      System.out.println(IntStream.range(1,10).map(i -> i*i).sum();
       }
}
~~~
{: .language-java}

## Exemple décortiqué :
^
mystere.hs : (Il s'agit du tri rapide, réécouter l'enregistrement du cours pour comprendre)

~~~
module Mystere where

import Data.List (sort)
import Test.QuickCheck

myst   [] = []
myst (x:xs) = myst ys ++ [x] ++ myst zs
     where ys = [ y | y <- xs, y < x]
     	   zs = [ z | z <- xs, z > x]

propriete xs =  myst xs == sort xs

propriete' (1:xs) = True
~~~
{: .language-haskell}

## Le compilateur :  GHC
^
Initialement "Glasgow Haskell Compiler", renommé "Glorious Haskell Compiler".  
GHCi -> REPL (Read-Eval-Print Loop)

## L'interpréteur :
^
~~~
*Mystere> 2
2
*Mystere> 2 + 3 * 4
20
*Mystere> sqrt 3 ^ 2 + 4 ^ 2
19.2
*Mystere> head [1,2,3,4]
1
*Mystere> head []
*** Exception : Prelude.head : empty list
*Mystere> tail [1,2,3,4]
[2,3,4]
*Mystere> tail []
*** Exception : Prelude.tail : empty list
*Mystere> [1,2,3] !! 2
3
*Mystere> drop 2 [1,2,3]
[3]
*Mystere> True
True
*Mystere> False
False
~~~

Attention aux majuscules en Haskell. Les noms de modules ont une majuscule, pareil pour les constantes.
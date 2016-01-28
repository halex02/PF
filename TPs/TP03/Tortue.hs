module Tortue where
import Graphics.Gloss
import Lsys

type EtatTortue = (Point, Float)
type Config     = (EtatTortue,
                   Float,
                   Float,
                   Float,
                   [Symbole])
type EtatDessin = (EtatTortue, Path)

etatInitial :: Config -> EtatTortue
etatInitial (e,_,_,_,_) = e

longueurPas :: Config -> Float
longueurPas (_,p,_,_,_) = p

facteurEchelle :: Config -> Float
facteurEchelle (_,_,f,_,_) = f

angle :: Config -> Float
angle (_,_,_,a,_) = a

symbolesTortue :: Config -> [Symbole]
symbolesTortue (_,_,_,_,s) = s

avance :: Config -> EtatTortue -> EtatTortue
avance c ((x,y),cap) = ((x',y'), cap)
  where
    x'= x+d*cos(cap)
    y'= y+d*sin(cap)
    d = facteurEchelle c

tourneAGauche :: Config -> EtatTortue -> EtatTortue
tourneAGauche c (p,cap) = (p, cap')
  where
    cap' = cap + angle c

tourneADroite :: Config -> EtatTortue -> EtatTortue
tourneADroite c (p,cap) = (p, cap')
  where
    cap' = cap - angle c

filtreSymbolesTortue :: Config -> Mot -> Mot
filtreSymbolesTortue c mot = filter (\x -> x `elem` (symbolesTortue c)) mot

interpreteSymbole :: Config -> EtatDessin -> Symbole -> EtatDessin
interpreteSymbole c ((pt, dir), path) 'F' = ((p, dir), p:path)
  where
    (p, _) = avance c (pt, dir)
interpreteSymbole c (e, path) '+'         = ((tourneAGauche c e), path)
interpreteSymbole c (e, path) '-'         = ((tourneADroite c e), path)

interpreteMot :: Config -> Mot -> Picture
interpreteMot c m = line path
  where
    (_, path)      = foldl (\etatDessin symbole -> interpreteSymbole c etatDessin symbole) etatDessinInit motFiltre
    motFiltre      = filtreSymbolesTortue c m
    etatDessinInit = (etatTortueInit, [premier])
    etatTortueInit = etatInitial c
    (premier, _)   = etatTortueInit

dessin = interpreteMot (((-150,0),0),100,1,pi/3,"F+-") "F+F--F+F"
main = display (InWindow "L-système" (1000, 1000) (0, 0)) white dessin



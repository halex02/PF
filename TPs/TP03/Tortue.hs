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
--main = display (InWindow "L-système" (1000, 1000) (0, 0)) white dessin

lsystemeAnime :: LSysteme -> Config -> Float -> Picture
lsystemeAnime lsys c i = interpreteMot c (lsys !! i)

vonKoch1 :: LSysteme
vonKoch1 = lsysteme "F" regles
    where regles 'F' = "F-F++F-F"
          regles  s  = [s]

vonKoch2 :: LSysteme
vonKoch2 = lsysteme "F++F++F++" regles
    where regles 'F' = "F-F++F-F"
          regles  s  = [s]

hilbert :: LSysteme
hilbert = lsysteme "X" regles
    where regles 'X' = "+YF-XFX-FY+"
          regles 'Y' = "-XF+YFY+FX-"
          regles  s  = [s]

dragon :: LSysteme
dragon = lsysteme "FX" regles
    where regles 'X' = "X+YF+"
          regles 'Y' = "-FX-Y"
          regles  s  = [s]

vonKoch1Anime :: Float -> Picture
vonKoch1Anime = lsystemeAnime vonKoch1 (((-400, 0), 0), 800, 1/3, pi/3, "F+-")

vonKoch2Anime :: Float -> Picture
vonKoch2Anime = lsystemeAnime vonKoch2 (((-400, -250), 0), 800, 1/3, pi/3, "F+-")

hilbertAnime :: Float -> Picture
hilbertAnime = lsystemeAnime hilbert (((-400, -400), 0), 800, 1/2, pi/2, "F+-")

dragonAnime :: Float -> Picture
dragonAnime = lsystemeAnime dragon (((0, 0), 0), 50, 1, pi/2, "F+-")

main = display (InWindow "L-système" (1000, 1000) (0, 0)) white (vonKoch1 (round 2 `mod` 10))



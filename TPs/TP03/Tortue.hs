module Tortue where
import Graphics.Gloss
import Lsys

type EtatTortue = (Point, Foat)
type Config     = (EtatTortue,
                   Float,
                   Float,
                   Float,
                   [Symbole])
type EtatDessin = (EtatTortue, Path)

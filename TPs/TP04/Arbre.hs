module Arbre where
  import Test.QuickCheck
  
  data Arbre c v = Noeud c v (Arbre c v) (Arbre c v) | Feuille deriving Show


  
  mapArbre :: ((c0,v0)->(c1,v1)) -> Arbre c0 v0 -> Arbre c1 v1
  mapArbre _ Feuille                               = Feuille
  mapArbre f (Noeud c v gauche droit)  = Noeud nc nv (mapArbre f gauche) (mapArbre f droit) 
    where
    (nc, nv) = f (c,v) 

  --foldArbre :: ( -> -> -> ) -> -> Arbre c0 v0-> 

  hauteur :: Arbre c v -> Int
  hauteur Feuille = 0
  hauteur (Noeud _ _ g d) = 1 + max (hauteur g) (hauteur d)
{-    | hauteur g < hauteur d = 1 + hauteur (d)
    | otherwise =  1 + hauteur (g)
-}
  taille :: Arbre c v -> Int
  taille Feuille = 0
  taille (Noeud _ _ g d) = 1+(taille g)+(taille d)

  peigneGauche :: [(c,v)] -> Arbre c v
  peigneGauche [] = Feuille  
  peigneGauche ((c, v):xs) = Noeud c v (peigneGauche xs) Feuille

  freeTree = Noeud "ROUGE" 'P' (Noeud "ROUGE" 'O' (Noeud "ROUGE" 'L' (Feuille) (Feuille))(Noeud "ROUGE" 'Y'(Feuille)(Feuille)))(Noeud "ROUGE" 'L'(Noeud "ROUGE" 'W'(Feuille)(Feuille))(Noeud "ROUGE" 'A'(Feuille)(Feuille)))


  prop_hauteurPeigne xs = length xs == hauteur (peigneGauche xs)
  

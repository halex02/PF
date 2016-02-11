module Arbre where
  import Test.QuickCheck
  
  data Arbre c v = Noeud c v (Arbre c v) (Arbre c v) | Feuille deriving Show


  
  mapArbre :: ((c0,v0)->(c1,v1)) -> Arbre c0 v0 -> Arbre c1 v1
  mapArbre _ Feuille                               = Feuille
  mapArbre f (Noeud c v gauche droit)  = Noeud nc nv (mapArbre f gauche) (mapArbre f droit) 
    where
    (nc, nv) = f (c,v) 

  foldArbre :: ( c -> v -> b -> b -> b) -> b -> Arbre c v-> b
  foldArbre _ v Feuille = v
  foldArbre f v (Noeud coul val a1 a2) = f coul val (foldArbre f v a1) (foldArbre f v a2)

  hauteur :: Arbre c v -> Int
  hauteur arbre = foldArbre (\c v a1 a2 -> 1 + (max a1 a2)) 0 arbre

  taille :: Arbre c v -> Int
  taille arbre = foldArbre (\c v a1 a2 -> 1 + a1 + a2) 0 arbre

  peigneGauche :: [(c,v)] -> Arbre c v
  peigneGauche [] = Feuille  
  peigneGauche ((c, v):xs) = Noeud c v (peigneGauche xs) Feuille

  freeTree = Noeud "ROUGE" 'P' (Noeud "ROUGE" 'O' (Noeud "ROUGE" 'L' (Feuille) (Feuille))(Noeud "ROUGE" 'Y'(Feuille)(Feuille)))(Noeud "ROUGE" 'L'(Noeud "ROUGE" 'W'(Feuille)(Feuille))(Noeud "ROUGE" 'A'(Feuille)(Feuille)))


  prop_hauteurPeigne xs = length xs == hauteur (peigneGauche xs)
  prop_taillePeigne xs = length xs == taille (peigneGauche xs)

  estComplet :: Arbre c a -> Bool
  estComplet Feuille = True
  estComplet (Noeud c v gauche droit) = ((taille gauche) == (taille droit)) && (estComplet gauche) && (estComplet droit)

  prop_CompletPeigne xs = estComplet (peigneGauche xs)
  
  
  


  

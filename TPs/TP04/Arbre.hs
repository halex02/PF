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
 
  
  splitEnt :: [(c,a)] -> ([(c,a)],(c,a),[(c,a)])
  splitEnt l =  (xs,r,ys)
    where xs = take ( (length l) `div` 2 ) l
          r  = last (take (( (length l) `div`2 )+1) l)
          ys = drop (( (length l) `div` 2 )) l
      



  complet :: Int -> [(c, a)] -> Arbre c a 
  complet 0 [] = Feuille
  complet x cs = Noeud (fst mid)  (snd mid)  (complet (x-1) gauche)  ( complet (x-1) droit)
    where (gauche,mid,droit) = splitEnt cs

  
      
  infinit :: x -> [x]
  infinit = iterate (\x -> x)

  
  create :: a -> ((),a)
  create a = ((),a)
  
  listAllChar = ['a'..]
  listAllCharTransf = [ (create x ) | x<-listAllChar ]
  
  aplatit :: Arbre c a -> [(c,a)]
  aplatit Feuille = [] 
  aplatit (Noeud c v gauche droit) = (aplatit gauche) ++ [(c,v)] ++ (aplatit droit)


  noeud :: (c -> String) -> (a -> String) -> (c,a) -> String
  noeud fc fa (c,a) = (fa a) ++ " [color="++(fc c)++", fontcolor="++(fc c)++"]" 
  
  listArcs :: Arbre c a -> Arbre c a -> Arbre c a -> [(a,a)]
  listArcs _ Feuille Feuille = []
  listArcs (Noeud _ v _ _) Feuille (Noeud _ v2 _ _) = [(v,v2)]  
  listArcs (Noeud _ v _ _) (Noeud _ v2 _ _) Feuille = [(v,v2)]  
  listArcs (Noeud _ v _ _) (Noeud _ v2 _ _) (Noeud _ v3 _ _)  =[(v,v2),(v,v3)] 

  arcs :: Arbre c a -> [(a,a)]
  arcs Feuille = [] 
  arcs (Noeud c v gauche droit) = (listArcs (Noeud c v gauche droit) gauche droit)  ++ arcs gauche ++ arcs droit

  arc :: (a -> String) -> (a,a) -> String
  arc f (a1,a2) = (f a1) ++ " -> " ++(f a2 ) 
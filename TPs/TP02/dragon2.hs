import Graphics.Gloss

main = animate (InWindow "Dragon" (500, 500) (0, 0)) white (dragonAnime (50, 250) (450, 250) 20)

dragonAnime a b t = Line (dragonOrdre a b t)

--Question 7 :
dragon :: Point -> Point -> [Path]
dragon a b = iterate pasDragon [a,b]

--Question 6 :
pasDragon :: Path -> Path
pasDragon []         = error "liste vide"
pasDragon [_]        = error "un seul point est donné" 
pasDragon [a,b]      = a:(pointAIntercaler a b):[b]
pasDragon [a,b,c]    = a:(pointAIntercaler a b):b:(pointAIntercaler c b):[c]
pasDragon (a:b:c:xs) = a:(pointAIntercaler a b):b:(pointAIntercaler c b):(pasDragon (c:xs))

--Question 5 :
pointAIntercaler :: Point -> Point -> Point
pointAIntercaler a b = ((fst a + fst b)/2 + (snd b - snd a)/2 , (snd a + snd b)/2 + (fst a - fst b)/2)

dragonOrdre :: Point -> Point -> Int -> Path
dragonOrdre a b 0 = [a,b]
dragonOrdre a b n = (dragonOrdre a c (n-1))++(tail(dragonOrdre c b (n-1))) where c = pointAIntercaler a b

--Houplon Alexandre & Toulouse Damien
import Graphics.Gloss

main = animate (InWindow "Dragon" (500, 500) (0, 0)) white (dragonAnime (50, 250) (450, 250))

dragonAnime a b t = Line (dragon a b !! (round t `mod` 20))

pointAIntercaler :: Point -> Point -> Point
pointAIntercaler a b = ((fst a + fst b)/2 + (snd b - snd a)/2 , (snd a + snd b)/2 + (fst a - fst b)/2)

dragonOrdre :: Point -> Point -> Int -> Path
dragonOrdre a b 0 = [a,b]
dragonOrdre a b n = (dragonOrdre a c (n-1))++(tail (reverse (dragonOrdre b c (n-1))))
                  where c = pointAIntercaler a b

dragon a b   =  map (dragonOrdre a b) [0..]
 

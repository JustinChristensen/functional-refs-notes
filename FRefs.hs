module FRefs where

data FRef s a = FRef { 
    get :: s -> a, 
    set :: a -> s -> s
}

fst :: FRef (x, y) x
fst = FRef { 
    get = \(x,y) -> x,
    set = \x (_,y) -> (x,y)
}
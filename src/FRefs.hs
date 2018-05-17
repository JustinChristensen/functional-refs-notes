module FRefs 
where

-- Ref typeclass 
-- r is of kind * -> * -> *
class Ref r where
    ref :: (a -> b) -> (b -> a -> a) -> r a b
    (.) :: r b c -> r a b -> r a c

-- type FRef is of kind * -> * -> *
-- FRef :: (s -> a) -> (a -> s -> s) -> FRef s a
-- FRef takes a function that takes a structure s and returns an a
--  and a function that takes an a and a structure s and returns a
--  new structure and returns a FRef s a
data FRef s a = FRef 
    { get :: s -> a
    , set :: a -> s -> s
    }

instance Ref FRef where
    ref = FRef
    (.) = compose

instance Ref (->) where
    ref = const
    (.) = (Prelude..)

data Person = Person 
    { firstName_ :: String
    , lastName_ :: String
    , salary_ :: Int
    } deriving (Show)

update :: FRef s a -> (a -> a) -> (s -> s)
update r f s = 
    set r -- set the result of the below operation on s
    (f (get r s)) -- get a from s and apply f to it
    s

compose :: FRef b c -> FRef a b -> FRef a c
compose bc ab = FRef 
    (get bc FRefs.. get ab) 
    (update ab FRefs.. set bc)

first :: Ref r => r (x, y) x
first = ref (\(x, _) -> x) (\x (_, y) -> (x, y))

second :: Ref r => r (x, y) y
second = ref (\(_, y) -> y) (\y (x, _) -> (x, y))

firstName :: Ref r => r Person String
firstName = ref firstName_ (\name person -> person { firstName_ = name })

lastName :: Ref r => r Person String
lastName = ref lastName_ (\name person -> person { lastName_ = name })

salary :: Ref r => r Person Int
salary = ref salary_ (\sal person -> person { salary_ = sal })

giveRaiseToSecond :: (a, Person) -> (a, Person)
giveRaiseToSecond  = update (salary FRefs.. second) (+10000)

module Main where

import FRefs

main :: IO ()
main = 
    let ron = Person { 
            firstName_ = "Ron", 
            lastName_ = "Swanson" , 
            salary_ = 64000 
        }
        giveRaise = update salary (+10000)
    in do
        print ron
        let ron2 = giveRaise ron
        print ron2


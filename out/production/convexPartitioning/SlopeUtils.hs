module SlopeUtils where

import Segment

type SlopeCoefficients = (Double, Double, Double)

simplify :: SlopeCoefficients -> SlopeCoefficients
simplify (a, b, c) = (a / m, b / m, c / m) where m = maximum [a, b, c]

-- |
--  Given two points (a segment), the 'coeffs' function
--  computes the coefficients a,b,c
--  of the associated line's general equation a x + b y = c
coeffs :: Segment -> SlopeCoefficients
coeffs segment = simplify (a, b, c)
  where
    (xa, ya) = (xOf $ endPoint segment, yOf $ endPoint segment)
    (xb, yb) = (xOf $ startPoint segment, yOf $ startPoint segment)
    a = ya - yb
    b = xb - xa
    c = (xa - xb) * ya + (yb - ya) * xa

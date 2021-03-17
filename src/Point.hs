{-# LANGUAGE DataKinds #-}

module Point where

import qualified Data.Geometry (Point(Point2))

data Point = Point {xOf :: Double, yOf :: Double} deriving (Eq)

instance Show Point where
  show p = "(" ++ show (xOf p) ++ ", " ++ show (yOf p) ++ ")"

-- |
--  Converts a point into a Point2 for the hgeometry library
--  (this is needed to compute the area of a polygon using the library function).
toPointOfGeoLib :: Point -> Data.Geometry.Point 2 Double
toPointOfGeoLib point = Data.Geometry.Point2 (xOf point) (yOf point)

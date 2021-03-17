module Segment where

import Data.Geometry.Polygon
  ( SimplePolygon,
    area,
    simpleFromPoints,
  )
import Data.Geometry.Polygon.Convex ()
import Point

data Segment = Segment {startPoint :: Point, endPoint :: Point} deriving (Show)

-- |
--  The 'isOnSegment' function verifies whether a point is on a segment.
isOnSegment :: Point -> Segment -> Bool
point `isOnSegment` segment =
  let a = startPoint segment
      b = endPoint segment
      crossProduct = (yOf point - yOf a) * (xOf b - xOf a) - (xOf point - xOf a) * (yOf b - yOf a)
      dotProduct = (xOf point - xOf a) * (xOf b - xOf a) + (yOf point - yOf a) * (yOf b - yOf a)
      squareLengthOf_b_a = (xOf b - xOf a) * (xOf b - xOf a) + (yOf b - yOf a) * (yOf b - yOf a)
   in not (abs crossProduct > 0.0000001 || dotProduct < 0 || dotProduct > squareLengthOf_b_a)

module Polygon where

import Data.Geometry.Polygon
  ( SimplePolygon,
    area,
    simpleFromPoints,
  )
import Data.Geometry.Polygon.Convex ()
import Point
import Data.Ext ( ext )

type ConvPolygon = [Point]

-- |
--  Converts a polygon into a SimplePolygon for the hgeometry library
--  (this is needed to compute the area using the library function).
toLibPolygon :: ConvPolygon -> SimplePolygon () Double
toLibPolygon polyg = simpleFromPoints (map (ext . toPointOfGeoLib) polyg)

areaOf :: ConvPolygon -> Double
areaOf poly = area $ toLibPolygon poly

module Polygon where

import Data.Ext (ext)
import Data.Geometry.Polygon
  ( SimplePolygon,
    area,
    simpleFromPoints,
  )
import Data.Geometry.Polygon.Convex ()
import Point

type ConvPolygon = [Point]

-- |
--  Converts a polygon into a SimplePolygon for the hgeometry library
--  (this is needed to compute the area using the library function).
toLibPolygon :: ConvPolygon -> SimplePolygon () Double
toLibPolygon polyg = simpleFromPoints (map (ext . toPointOfGeoLib) polyg)

areaOf :: ConvPolygon -> Double
areaOf poly = area $ toLibPolygon poly

-- |
--  The 'without' function returns the polygon resulting from
--  the subtraction of 'partition' from 'mainPolygon'
without :: ConvPolygon -> ConvPolygon -> ConvPolygon
mainPolygon `without` partition = head mainPolygon : last partition : withoutHelper mainPolygon partition

withoutHelper :: ConvPolygon -> ConvPolygon -> ConvPolygon
withoutHelper mainPolygon partition
  | null mainPolygon = []
  | null partition || head mainPolygon /= head partition = head mainPolygon : withoutHelper (tail mainPolygon) (safeTail partition)
  | otherwise = withoutHelper (tail mainPolygon) (tail partition)

safeTail :: ConvPolygon -> ConvPolygon
safeTail polyg
  | null polyg = []
  | otherwise = tail polyg

module Partitioner where

import Point
import Polygon
import Segment
import SlopeUtils

-- |
--  The 'reversedShoelace' function finds any of the two (see sign) points Φ
--  such that the polygon [designatedVertex - v_ip1 - Φ] has targetArea
reversedShoelace :: Double -> SlopeCoefficients -> Point -> Point -> Double -> Point
reversedShoelace targetArea (a, b, c) designatedVertex v_ip1 sign
  | b == 0 = Point (- c / a) ((-2 * sign * targetArea - y1 * (a * x2 + c) + y2 * (a * x1 + c)) / (a * (x1 - x2)))
  | otherwise = Point ((2 * targetArea * sign * b + x2 * (b * y1 + c) - x1 * (b * y2 + c)) / (a * x1 - a * x2 + b * (y1 - y2))) ((-2 * sign * targetArea * a - y1 * (a * x2 + c) + y2 * (a * x1 + c)) / (a * x1 - a * x2 + b * (y1 - y2)))
  where
    x1 = xOf designatedVertex
    y1 = yOf designatedVertex
    x2 = xOf v_ip1
    y2 = yOf v_ip1

-- |
--  The 'findMagicPoint' function finds the point Φ located on the edge 'seg'
--  such that the polygon [designatedVertex - v_ip1 - Φ] has targetArea
findMagicPoint :: Double -> Segment -> Point -> Point
findMagicPoint targetArea seg designatedVertex
  | magicPoint1 `isOnSegment` seg = magicPoint1
  | otherwise = magicPoint2
  where
    slopeCoefficients = coeffs seg
    v_ip1 = startPoint seg
    magicPoint1 = reversedShoelace targetArea slopeCoefficients designatedVertex v_ip1 (-1)
    magicPoint2 = reversedShoelace targetArea slopeCoefficients designatedVertex v_ip1 1

-- |
--  The 'without' function returns the polygon resulting from
--  the subtraction of 'partition' from 'mainPolygon'
without :: ConvPolygon -> ConvPolygon -> ConvPolygon
mainPolygon `without` partition = head mainPolygon : last partition : drop (length partition) mainPolygon

-- |
--  The 'cut' function returns a partition having 'targetArea' AND
--  the remaining part of the original cut polygon.
cut :: ConvPolygon -> Double -> Point -> Int -> (ConvPolygon, ConvPolygon)
cut polygon targetArea designatedVertex i
  | areaOf currentTriangle == targetArea = (currentTriangle, polygon `without` currentTriangle)
  | areaOf currentTriangle > targetArea =
    let magicPoint = findMagicPoint targetArea (Segment v_ip1 v_ip2) designatedVertex
        extractedPartition = take i polygon ++ [magicPoint]
     in (extractedPartition, polygon `without` extractedPartition)
  | otherwise =
    let residualArea = targetArea - areaOf currentTriangle
     in cut polygon residualArea designatedVertex (i + 1)
  where
    v_ip1 = polygon !! i
    v_ip2 = polygon !! (i + 1)
    currentTriangle = [designatedVertex, v_ip1, v_ip2]

computePartitionsHelper :: ConvPolygon -> Int -> Double -> Point -> [ConvPolygon]
computePartitionsHelper polygon numOfPartitions targetArea designatedVertex
  | numOfPartitions == 1 = [polygon]
  | otherwise = currentPartition : computePartitionsHelper remainingPolygon (numOfPartitions -1) targetArea designatedVertex
  where
    (currentPartition, remainingPolygon) = cut polygon targetArea designatedVertex 0

-- |
--  The 'computePartitions' function computes a list
--  of all 'numOfPartitions' partitions of a polygon.
computePartitions :: ConvPolygon -> Int -> [ConvPolygon]
computePartitions polygon numOfPartitions = computePartitionsHelper polygon numOfPartitions targetArea designatedVertex
  where
    targetArea = areaOf polygon / fromIntegral numOfPartitions
    designatedVertex = head polygon

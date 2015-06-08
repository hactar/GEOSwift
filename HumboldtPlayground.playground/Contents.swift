import UIKit
import Humboldt
import MapKit
//: # Humboldt
//: _Topography made simple, in Swift._
//:
//: Handle all kind of geographical objects (points, linestrings, polygons etc.) and all related topographic operations (intersections, overlapping etc.) easily.
//: Humboldt is basically a MIT-licensed Swift interface to the OSGeo's GEOS library routines*, plus some convenience features for iOS developers as:
//: * MapKit integration
//: * GEOJSON parsing
//:
//: ### Handle a geographical data model
//:
//:     Point, LineString, Polygon, MultiPoint, MultiLineString, MultiPolygon, GeometryCollection
//:

// Create a POINT from its WKT representation
let point = Waypoint(WKT: "POINT(10 45)")

// A geometry can be created even using the constructor `Geometry.create(WKT)` and casting the returned value to the desired subclass
let geometry1 = Geometry.create("POLYGON((35 10, 45 45.5, 15 40, 10 20, 35 10),(20 30, 35 35, 30 20, 20 30))")

// The same geometry can be represented in binary form as a Well Known Binary.
// Let's create one from a hex string:
let wkb = NSData.fromHexString("010300000002000000050000000000000000804140000000000000244000000000008046400000000000C046400000000000002E40000000000000444000000000000024400000000000003440000000000080414000000000000024400400000000000000000034400000000000003E40000000000080414000000000008041400000000000003E40000000000000344000000000000034400000000000003E40")
let geometry2 = Geometry.create(wkb.bytes, size: wkb.length)

if geometry1 == geometry2 && geometry1 != point {
    println("The two geometries are equal!\nAh, and geometry objects conform to the Equatable protocol.")
}

// Examples of valid WKT geometries representations are:
// POINT(6 10)
// LINESTRING(35 10, 45 45, 15 40, 10 20, 35 10)
// LINESTRING(3 4,10 50,20 25)
// POLYGON((1 1,5 1,5 5,1 5,1 1),(2 2, 3 2, 3 3, 2 3,2 2))
// MULTIPOINT(3.5 5.6,4.8 10.5)
// MULTILINESTRING((3 4,10 50,20 25),(-5 -8,-10 -8,-15 -4))
// MULTIPOLYGON(((1 1,5 1,5 5,1 5,1 1),(2 2, 3 2, 3 3, 2 3,2 2)),((3 3,6 2,6 4,3 3)))
// GEOMETRYCOLLECTION(POINT(4 6),LINESTRING(4 6,7 10))

//: ### Mapkit integration
//:
//: Convert the geometries to a MKShape subclass, ready to be added as annotations to a MKMapView
//:
let shape1 = point!.mapShape()
let shape2 = geometry1!.mapShape()
let annotations = [shape1, shape2]

//: ### GEOJSON parsing
//:
//: Your geometries can be loaded from a GEOJSON file.
//:
if let geoJSONURL = NSBundle.mainBundle().URLForResource("multipolygon", withExtension: "geojson"),
    let geometries = Geometry.fromGeoJSON(geoJSONURL),
    let italy = geometries[0] as? MultiPolygon
{
    italy
}

//: ### Topological operations:
//:
//: Buffer, Boundary, Centroid, ConvexHull, Envelope, PointOnSurface, Intersection, Difference, Union

// TODO: examples

//: ### Predicates:
//: 
//: Intersects, Touches, Disjoint, Crosses, Within, Contains, Overlaps, Equals, Covers

// TODO: examples

//: * [GEOS](http://trac.osgeo.org/geos/) stands for Geometry Engine - Open Source, and is a C++ library, ported from the [Java Topology Suite](http://sourceforge.net/projects/jts-topo-suite/). GEOS implements the OpenGIS [Simple Features for SQL](http://www.opengeospatial.org/standards/sfs) spatial predicate functions and spatial operators. GEOS, now an OSGeo project, was initially developed and maintained by [Refractions Research](http://www.refractions.net/) of Victoria, Canada.
//:
//: Humboldt was released by Andrea Cremaschi ([@andreacremaschi](https://twitter.com/andreacremaschi)) under a MIT license. See LICENSE for more information.
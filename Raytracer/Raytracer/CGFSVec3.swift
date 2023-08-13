//
//  CGFSVec3.swift
//  Raytracer
//
//  Created by Eric Berna on 8/11/23.
//

import Foundation

infix operator •
infix operator ×

struct CGFSVec3 {
    
    static var zero: CGFSVec3 {
        get {
            return CGFSVec3(x: 0, y: 0, z: 0)
        }
    }
    
    var x: Double = 0.0
    var y: Double = 0.0
    var z: Double = 0.0
    var r: Double { return x }
    var g: Double { return y }
    var b: Double { return z }
    
    init(x: Double = 0.0, y: Double = 0.0, z: Double = 0.0) {
        self.x = x
        self.y = y
        self.z = z
    }

    static func +(lhs: CGFSVec3, rhs: CGFSVec3) -> CGFSVec3 {
        return CGFSVec3(x: lhs.x + rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z)
    }
    
    static func *(lhs: CGFSVec3, rhs: Double) -> CGFSVec3 {
        return CGFSVec3(x: lhs.x * rhs, y: lhs.y * rhs, z: lhs.z * rhs)
    }
    
    static func *(lhs: Double, rhs: CGFSVec3) -> CGFSVec3 {
        return CGFSVec3(x: lhs * rhs.x, y: lhs * rhs.y, z: lhs * rhs.z)
    }
    
    static func *(lhs: CGFSVec3, rhs: CGFSVec3) -> CGFSVec3 {
        return CGFSVec3(x: lhs.x * rhs.x, y: lhs.y * rhs.y, z: lhs.z * rhs.z)
    }
    
    static func /(lhs: CGFSVec3, rhs: Double) -> CGFSVec3 {
        return CGFSVec3(x: lhs.x / rhs, y: lhs.y / rhs, z: lhs.z / rhs)
    }
    
    static func -(lhs: CGFSVec3, rhs: CGFSVec3) -> CGFSVec3 {
        return CGFSVec3(x: lhs.x - rhs.x, y: lhs.y - rhs.y, z: lhs.z - rhs.z)
    }
    
    static prefix func -(rhs: CGFSVec3) -> CGFSVec3 {
        return -1.0 * rhs
    }
    
    static func •(lhs: CGFSVec3, rhs: CGFSVec3) -> Double {
        return (lhs.x * rhs.x) + (lhs.y * rhs.y) + (lhs.z * rhs.z)
    }
    
    static func ×(lhs: CGFSVec3, rhs: CGFSVec3) -> CGFSVec3 {
        return CGFSVec3(x: (lhs.y * rhs.z - lhs.z * rhs.y), y: -(lhs.x * rhs.z - lhs.z * rhs.x), z: (lhs.x * rhs.y - lhs.y * rhs.x))
    }
    
    var unit: CGFSVec3 {
        return self / self.length
    }
    
    var length: Double {
        return sqrt(self • self)
    }
    func squaredLength() -> Double {
        return self • self
    }
        
    func refract(normal: CGFSVec3, niOverNt: Double) -> CGFSVec3? {
        let unit = self.unit
        let dot = unit • normal
        let discriminant = 1.0 - niOverNt * niOverNt * (1 - dot * dot)
        if discriminant > 0 {
            return niOverNt * (unit - normal * dot) - normal * sqrt(discriminant)
        } else {
            return nil
        }
    }
        
    subscript(index: Int) -> Double {
        get {
            switch index {
            case 0:
                return x
            case 1:
                return y
            case 2:
                return z
            default:
                return Double.nan
            }
        }
        set(newValue) {
            switch index {
            case 0:
                 x = newValue
            case 1:
                 y = newValue
            case 2:
                 z = newValue
            default:
                break
            }
        }
        
    }
    
}

//
//  CGFSColor.swift
//  Raytracer
//
//  Created by Eric Berna on 8/7/23.
//

import Foundation

struct CGFSColor {
    
    var r: UInt8
    var g: UInt8
    var b: UInt8
    var a: UInt8
    
    init(r: UInt8, g: UInt8, b: UInt8, a: UInt8 = 255) {
        self.r = r
        self.g = g
        self.b = b
        self.a = a
    }
    
    static func *(lhs: CGFSColor, rhs: Double) -> CGFSColor {
        return CGFSColor(
            r: UInt8(min(Double(lhs.r) * rhs, Double(UInt8.max))),
            g: UInt8(min(Double(lhs.g) * rhs, Double(UInt8.max))),
            b: UInt8(min(Double(lhs.b) * rhs, Double(UInt8.max))),
            a: lhs.a
        )
    }
    
    static func *(lhs: Double, rhs: CGFSColor) -> CGFSColor {
        return CGFSColor(
            r: UInt8(min(Double(rhs.r) * lhs, Double(UInt8.max))),
            g: UInt8(min(Double(rhs.g) * lhs, Double(UInt8.max))),
            b: UInt8(min(Double(rhs.b) * lhs, Double(UInt8.max))),
            a: rhs.a
        )
    }


}

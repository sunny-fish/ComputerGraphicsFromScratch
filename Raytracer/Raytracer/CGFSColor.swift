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
    
}

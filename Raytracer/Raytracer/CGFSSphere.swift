//
//  CGFSSphere.swift
//  Raytracer
//
//  Created by Eric Berna on 8/12/23.
//

import Foundation

struct CGFSSphere {
    let center: CGFSVec3
    let radius: Double
    let color: CGFSColor
    let specular: Double
    
    init(center: CGFSVec3, radius: Double, color: CGFSColor, specular: Double = 0.0) {
        self.center = center
        self.radius = radius
        self.color = color
        self.specular = specular
    }
}

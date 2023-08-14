//
//  CGFSLight.swift
//  Raytracer
//
//  Created by Eric Berna on 8/13/23.
//

import Foundation

enum CGFSLightType {
    case ambient
    case point
    case directional
}

struct CGFSLight {
    let type: CGFSLightType
    let intensity: Double
    let position: CGFSVec3?
}

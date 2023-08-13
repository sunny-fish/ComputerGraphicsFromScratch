//
//  CGFSScene.swift
//  Raytracer
//
//  Created by Eric Berna on 8/12/23.
//

import Foundation

struct CGFSScene {
    let spheres: [CGFSSphere]
    
    init(spheres: [CGFSSphere]? = nil) {
        if let spheres {
            self.spheres = spheres
        } else {
            self.spheres = [
                CGFSSphere(center: CGFSVec3(x: 0, y: -1, z: 3), radius: 1, color: CGFSColor(r: 255, g: 0, b: 0)),
                CGFSSphere(center: CGFSVec3(x: 2, y: 0, z: 4), radius: 1, color: CGFSColor(r: 0, g: 0, b: 255)),
                CGFSSphere(center: CGFSVec3(x: -2, y: 0, z: 4), radius: 1, color: CGFSColor(r: 0, g: 255, b: 0))
            ]
        }
    }
}

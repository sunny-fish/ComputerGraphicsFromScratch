//
//  CGFSScene.swift
//  Raytracer
//
//  Created by Eric Berna on 8/12/23.
//

import Foundation

struct CGFSScene {
    
    let spheres: [CGFSSphere]?
    let lights: [CGFSLight]?
    
    init(spheres: [CGFSSphere]? = nil, lights: [CGFSLight]? = nil) {
        self.spheres = spheres
        self.lights = lights
    }
    
}

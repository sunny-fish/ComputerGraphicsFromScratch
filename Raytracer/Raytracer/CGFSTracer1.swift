//
//  CGFSTracer1.swift
//  Raytracer
//
//  Created by Eric Berna on 8/11/23.
//
//  Implements the ray tracer from the second chapter of
//  Computer Graphics From Scratch.

import Foundation

class CGFSTracer1: CGFSTracer {
    
    override var scene: CGFSScene {
        get {
            self.sceneStorage
        }
    }
    
    private var sceneStorage = CGFSScene(spheres: [
            CGFSSphere(center: CGFSVec3(x: 0, y: -1, z: 3), radius: 1, color: CGFSColor(r: 255, g: 0, b: 0)),
            CGFSSphere(center: CGFSVec3(x: 2, y: 0, z: 4), radius: 1, color: CGFSColor(r: 0, g: 0, b: 255)),
            CGFSSphere(center: CGFSVec3(x: -2, y: 0, z: 4), radius: 1, color: CGFSColor(r: 0, g: 255, b: 0))
        ])

    override func traceRay(cameraPosition: CGFSVec3, direction: CGFSVec3, from tMin: Double = 1, to tMax: Double = .infinity) -> CGFSColor {
        var closestT = Double.infinity
        var closestSphere: CGFSSphere? = nil
        let range = tMin...tMax
        if let spheres = scene.spheres {
            for sphere in spheres {
                let (t1, t2) = intersectRaySphere(cameraPosition: cameraPosition, direction: direction, sphere: sphere)
                if let t1, range.contains(t1), t1 < closestT {
                    closestT = t1
                    closestSphere = sphere
                }
                if let t2, range.contains(t2), t2 < closestT {
                    closestT = t2
                    closestSphere = sphere
                }
            }
        }
        return closestSphere?.color ?? backgroundColor
    }

}

//
//  CGFSTracer2.swift
//  Raytracer
//
//  Created by Eric Berna on 8/13/23.
//

import Foundation

class CGFSTracer2: CGFSTracer {
    
    override var scene: CGFSScene {
        get {
            self.sceneStorage
        }
    }
    
    private var sceneStorage = CGFSScene(
        spheres: [
            CGFSSphere(center: CGFSVec3(x: 0, y: -1, z: 3), radius: 1, color: CGFSColor(r: 255, g: 0, b: 0)),
            CGFSSphere(center: CGFSVec3(x: 2, y: 0, z: 4), radius: 1, color: CGFSColor(r: 0, g: 0, b: 255)),
            CGFSSphere(center: CGFSVec3(x: -2, y: 0, z: 4), radius: 1, color: CGFSColor(r: 0, g: 255, b: 0)),
            CGFSSphere(center: CGFSVec3(x: 0, y: -5001, z: 0), radius: 5000, color: CGFSColor(r: 255, g: 255, b: 0))
        ],
        lights: [
            CGFSLight(type: .ambient, intensity: 0.2, position: nil),
            CGFSLight(type: .point, intensity: 0.6, position: CGFSVec3(x: 2, y: 1, z: 0)),
            CGFSLight(type: .directional, intensity: 0.2, position: CGFSVec3(x: 1, y: 4, z: 4))
                      
        ]
    )
    
    func computeLighting(point: CGFSVec3, normal: CGFSVec3) -> Double {
        var result = 0.0
        guard let lights = scene.lights else {
            return result
        }
        var direction = CGFSVec3.zero
        for light in lights {
            if light.type == .ambient {
                result += light.intensity
            } else {
                if let position = light.position {
                    if light.type == .point {
                        direction = position - point
                    } else {
                        direction = position
                    }
                    let normalDotDirection = normal • direction
                    if normalDotDirection > 0 {
                        result += light.intensity * normalDotDirection / (normal.length * direction.length)
                    }
                }
            }
        }
        result = min(1.0, max(0.0, result))
        return result
    }
    
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
        guard let closestSphere else {
            return backgroundColor
        }
        let point = cameraPosition + closestT * direction
        let normalDirection = (point - closestSphere.center)
        let normal = normalDirection / normalDirection.length
        let light = computeLighting(point: point, normal: normal)
        return closestSphere.color * light
        
    }
    

}

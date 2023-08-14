//
//  CGFSTracer1.swift
//  Raytracer
//
//  Created by Eric Berna on 8/11/23.
//
//  Implements the ray tracer from the second chapter of
//  Computer Graphics From Scratch.

import Foundation

class CGFSTracer {
    
    let viewPortWidth: Double = 1
    let viewPortHeight: Double = 1
    let viewPortDistance: Double = 1
    let canvasWidth: Int
    let canvasHeight: Int
    let canvas: CGFSCanvas
    let backgroundColor = CGFSColor(r: 192 , g: 192, b: 192)
    var scene: CGFSScene {
        get {
            self.sceneStorage
        }
    }
    private var sceneStorage = CGFSScene()
    
    init(canvasWidth: Int = 500, canvasHeight: Int = 500) {
        self.canvasWidth = canvasWidth
        self.canvasHeight = canvasHeight
        self.canvas = CGFSCanvas(width: canvasWidth, height: canvasHeight)
        self.render()
    }
    
    func canvasToViewport(x: Int, y: Int) -> CGFSVec3 {
        CGFSVec3(x: Double(x) * viewPortWidth / Double(canvasWidth), y: Double(y) * viewPortHeight / Double(canvasHeight), z: Double(viewPortDistance))
    }
    
    func intersectRaySphere(cameraPosition: CGFSVec3, direction: CGFSVec3, sphere: CGFSSphere) -> (Double?, Double?) {
        let r = sphere.radius
        let co = cameraPosition - sphere.center
        let a = direction • direction
        let b = 2 * (co • direction)
        let c = (co • co) - (r * r)
        let discriminant = b * b - 4 * a * c
        if discriminant < 0 {
            return (nil, nil)
        }
        let t1 = (-b + sqrt(discriminant)) / (2 * a)
        let t2 = (-b - sqrt(discriminant)) / (2 * a)
        return (t1, t2)
    }
    
    func traceRay(cameraPosition: CGFSVec3, direction: CGFSVec3, from tMin: Double = 1, to tMax: Double = .infinity) -> CGFSColor {
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
    
    func render() {
        let cameraPosition = CGFSVec3.zero
        
        for x in (-canvasWidth/2)...(canvasWidth/2) {
            for y in (-canvasHeight/2)...(canvasHeight/2) {
                let direction = canvasToViewport(x: x, y: y)
                let color = traceRay(cameraPosition: cameraPosition, direction: direction)
                canvas.putPixel(x: x, y: y, color: color)
            }
        }

    }
    
}

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

    
}

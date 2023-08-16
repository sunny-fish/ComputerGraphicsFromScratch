//
//  CGFSTracer.swift
//  Raytracer
//
//  Created by Eric Berna on 8/15/23.
//

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
        return CGFSColor(r: 200, g: 200, b: 200)
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

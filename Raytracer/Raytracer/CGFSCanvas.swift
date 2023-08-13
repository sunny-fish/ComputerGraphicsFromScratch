//
//  CGFSCanvas.swift
//  Raytracer
//
//  Created by Eric Berna on 8/7/23.
//

import Foundation
import AppKit

class CGFSCanvas {
    
    var width: Int
    var height: Int
    var pixels: [CGFSColor]

    init(width: Int, height: Int) {
        self.width = width
        self.height = height
        let grey = CGFSColor(r: 127, g: 127, b: 127)
        self.pixels = [CGFSColor](repeating: grey, count: width * height)
    }
    
    func putPixel(x: Int, y: Int, color: CGFSColor) {
        let sx = width / 2 + x
        let sy = height / 2 - y
        if (sx > 0 && sx < width) && (sy > 0 && sy < height) {
            pixels[sx + sy * width] = color
        }
    }
    
    func nsImage() -> NSImage {
        let bitsPerComponent = 8
        let bitsPerPixel = 32
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let pixelSize = MemoryLayout<CGFSColor>.size
        let data = NSData(bytes: pixels, length: pixels.count * pixelSize)
        let provider = CGDataProvider.init(data: data)
        let image = CGImage.init(width: width, height: height, bitsPerComponent: bitsPerComponent, bitsPerPixel: bitsPerPixel, bytesPerRow: pixelSize * width, space: rgbColorSpace, bitmapInfo: bitmapInfo, provider: provider!, decode: nil, shouldInterpolate: true, intent: CGColorRenderingIntent.defaultIntent)
        return NSImage(cgImage: image!, size: NSSize(width: width, height: height))
    }
}

//
//  ContentView.swift
//  Raytracer
//
//  Created by Eric Berna on 8/7/23.
//

import SwiftUI

struct ContentView: View {
    
    let tracer = CGFSTracer2()
    
    var body: some View {
        VStack {
            Image(nsImage: tracer.canvas.nsImage())
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

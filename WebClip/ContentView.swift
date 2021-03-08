//
//  ContentView.swift
//  WebClip
//
//  Created by Mamunul Mazid on 3/8/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Button {
            WebClipGenerator().generate()
        } label: {
            Text("Generate WebClip")
                .padding()
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

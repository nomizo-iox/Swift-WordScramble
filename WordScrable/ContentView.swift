//
//  ContentView.swift
//  WordScrable
//
//  Created by Samuel F. Ademola on 12/22/19.
//  Copyright © 2019 Nomizo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        if let fileURL = Bundle.main.url(forResource: "Some-file", withExtension: "txt") {
            // We found the file in our bundle!
            
            if let fileContent = try? String(contentsOf: fileURL) {
                // We loaded the file into a string
            }
        }
        
       return Text("Hello, Sam")
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

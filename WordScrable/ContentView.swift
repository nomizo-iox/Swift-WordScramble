//
//  ContentView.swift
//  WordScrable
//
//  Created by Samuel F. Ademola on 12/22/19.
//  Copyright © 2019 Nomizo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let heroes = ["Thanos", "Iron-Man", "Black Panther", "Captain America", "Spider-Man", "Black Widown", "Hulk", "Ant-Man", "Doctor Strange", "Blade", "Deadpool"]
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(heroes, id:\.self) {
                    Text($0)
                }
            }
        .navigationBarTitle("MCU")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  StretchyScrollApp
//
//  Created by Thomas Sivilay on 8/8/19.
//  Copyright © 2019 Thomas Sivilay. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 0
 
    var body: some View {
        TabView(selection: $selection){
            FormExample()
                .tabItem {
                    VStack {
                        Image("first")
                        Text("Form")
                    }
                }
                .tag(0)
            ListExample()
                .tabItem {
                    VStack {
                        Image("second")
                        Text("List")
                    }
                }
                .tag(1)
            ScrollViewExample()
                .tabItem {
                    VStack {
                        Image("second")
                        Text("ScrollView")
                    }
                }
                .tag(2)
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif

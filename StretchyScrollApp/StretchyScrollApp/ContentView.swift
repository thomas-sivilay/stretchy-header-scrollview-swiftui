//
//  ContentView.swift
//  StretchyScrollApp
//
//  Created by Thomas Sivilay on 8/8/19.
//  Copyright © 2019 Thomas Sivilay. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 2
 
    var body: some View {
        TabView(selection: $selection) {
            NavigationView {
                FormExample()
                    .navigationBarTitle("Form")
            }
            .tabItem {
                VStack {
                    Image("first")
                    Text("Form")
                }
            }
            .tag(0)
            
            NavigationView {
                ListExample()
                    .navigationBarTitle("List")
            }
            .tabItem {
                VStack {
                    Image("second")
                    Text("List")
                }
            }
            .tag(1)
            
            NavigationView {
                ScrollViewExample()
                    .navigationBarTitle("Scroll", displayMode: .inline)
            }
            .tabItem {
                VStack {
                    Image("second")
                    Text("ScrollView")
                }
            }
            .tag(2)
        }
        .edgesIgnoringSafeArea(.top)
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif

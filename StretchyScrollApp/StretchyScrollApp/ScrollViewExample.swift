//
//  ScrollView.swift
//  StretchyScrollApp
//
//  Created by Thomas Sivilay on 8/8/19.
//  Copyright © 2019 Thomas Sivilay. All rights reserved.
//

import SwiftUI

struct ScrollViewExample: View {
    
    @State private var offset: CGFloat = 0
    
    var staticHeight: CGFloat = 84
    var extraHeight: CGFloat = 240
    var headerHeight: CGFloat {
        max(self.offset - 32, staticHeight)
    }
    var maxHeaderHeight: CGFloat {
        staticHeight + extraHeight
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                ScrollViewHeaderView(offset: self.offset,
                                     desiredHeight: self.headerHeight + geometry.safeAreaInsets.top)
                    .zIndex(2)
                
                ScrollViewContentView(offset: self.headerHeight)
                    .coordinateSpace(name: "myZstack")
                    .offset(y: min(self.headerHeight, self.maxHeaderHeight) + geometry.safeAreaInsets.top)
                    .zIndex(1)
                
            }
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { delta in
                self.offset = delta - geometry.safeAreaInsets.top
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct ScrollViewHeaderView: View {
    
    var offset: CGFloat
    var desiredHeight: CGFloat

    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .bottom) {
                Image("catalina")
                    .resizable()
                    .aspectRatio(1, contentMode: .fill)
                    .frame(height: self.desiredHeight)
                    .clipped()
                    .opacity(Double((self.desiredHeight - 128) / 200))
                
                VStack(spacing: 4) {
                    Text("Height: \(self.desiredHeight)")
                        .bold()
                        .multilineTextAlignment(.center)
                        .font(.title)
                    Text("Content offset: \(self.offset)")
                        .bold()
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .padding(.bottom, 8)
                    Divider()
                }
                .background(Color.white)
            }
            .background(Color.white)
        }
        .frame(height: self.desiredHeight)
    }
}

struct ScrollOffsetPreferenceKey: PreferenceKey, Equatable {
    static var defaultValue: CGFloat = 0
        
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

struct ScrollViewContentView: View {
    
    var offset: CGFloat
    
    var body: some View {
        GeometryReader { proxy -> AnyView in
            return AnyView(
                Form {
                    GeometryReader { epProxy -> AnyView in
                        return AnyView(
                            Text("\(epProxy.frame(in: .named("myZstack")).minY)")
                                .preference(key: ScrollOffsetPreferenceKey.self,
                                            value: epProxy.frame(in: .named("myZstack")).minY)
                        )
                    }
                                            
                    Section(header: Text("0")) {
                        Text("Offset: \(self.offset)")
                        
                        NavigationLink(destination: DetailView(title: "Nav")) {
                            Text("Navigation link")
                        }
                        Text("\(proxy.size.debugDescription)")
                    }
                    Section(header: Text("1")) {
                        NavigationLink(destination: DetailView(title: "Nav")) {
                            Text("\(proxy.frame(in: .named("myZstack")).debugDescription)")
                        }
                        Text("Row 3 - \(self.offset)")
                        Text("Row 4")
                        Text("Row 5")
                        NavigationLink(destination: DetailView(title: "Nav")) {
                            Text("Row 6")
                        }
                    }
                    Section(header: Text("2")) {
                        Text("Row 7")
                        Text("Row 8")
                        Text("Row 9")
                        Text("Row 10")
                        Text("Row 11")
                    }
                    Section(header: Text("3")) {
                        Text("Row 12")
                        Text("Row 13")
                        Text("Row 14")
                        Text("Row 15")
                        Text("Row 16")
                    }

                }
                .frame(width: proxy.size.width)
            )
        }
    }
}

#if DEBUG
struct ScrollViewExample_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ScrollViewExample()
            
            NavigationView {
                ScrollViewExample()
                    .navigationBarTitle("Title", displayMode: .inline)
            }
        }
    }
}
#endif



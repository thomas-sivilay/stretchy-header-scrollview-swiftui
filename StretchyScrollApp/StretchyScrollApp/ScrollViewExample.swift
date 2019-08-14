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
    @State private var imageHeight: CGFloat = 100
    
    var body: some View {
        ZStack {
            ScrollViewHeaderView(offset: $offset, imageHeight: $imageHeight)
                .zIndex(10)
            ScrollViewContentView(offset: $offset)
                .offset(x: 0, y: (imageHeight))
                .zIndex(1)
        }
        .coordinateSpace(name: "myZstack")
        .onPreferenceChange(ScrollOffsetPreferenceKey.self) {
            print($0)
            self.offset = $0.first ?? 0
        }
    }
}

struct ScrollViewHeaderView: View {
    
    @Binding var offset: CGFloat
    @Binding var imageHeight: CGFloat

    var body: some View {
        GeometryReader { proxy -> AnyView in
            return AnyView(
                ZStack {
                    Image("catalina")
                        .scaleEffect(0.25)
                        .frame(height: max(self.offset, self.imageHeight))
                        .clipped()
                    VStack(spacing: 4) {
                        Text("Content offset: \(self.offset)")
                            .foregroundColor(.white)
                            .bold()
                            .multilineTextAlignment(.center)
                            .font(.title)
                    }
                }
                .frame(width: proxy.size.width, height: max(self.offset, self.imageHeight))
                .clipped()
            )
        }
    }
}

struct ScrollOffsetPreferenceKey: PreferenceKey, Equatable {
    static var defaultValue: [CGFloat] = []
    
    static func reduce(value: inout [CGFloat], nextValue: () -> [CGFloat]) {
        value.append(contentsOf: nextValue())
    }
}

struct ScrollViewContentView: View {
    
    let correction: CGFloat = 85 + 44
    @Binding var offset: CGFloat
    
    var body: some View {
        GeometryReader { proxy -> AnyView in
            return AnyView(
                Form {
                    GeometryReader { epProxy -> AnyView in
                        return AnyView(
                            Text("\(epProxy.frame(in: .named("myZstack")).minY - self.correction)")
                                .preference(key: ScrollOffsetPreferenceKey.self,
                                            value: [epProxy.frame(in: .named("myZstack")).minY - self.correction])
                        )
                    }
                                            
                    Section(header: Text("0")) {
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
        ScrollViewExample()
    }
}
#endif



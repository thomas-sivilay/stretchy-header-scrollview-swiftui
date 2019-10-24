//
//  ScrollView.swift
//  StretchyScrollApp
//
//  Created by Thomas Sivilay on 8/8/19.
//  Copyright © 2019 Thomas Sivilay. All rights reserved.
//

import SwiftUI

struct StacyHeader<Header: View>: ViewModifier {
    
    @State private var offset: CGFloat
    
    private var magicNumber: CGFloat = 32
    
    var staticHeight: CGFloat
    var extraHeight: CGFloat
    var headerBuilder: (_ desiredHeight: CGFloat) -> Header
    
    init(staticHeight: CGFloat, extraHeight: CGFloat, @ViewBuilder content: @escaping (CGFloat) -> Header) {
        self.staticHeight = staticHeight
        self.extraHeight = extraHeight
        self.headerBuilder = content
        self._offset = State(initialValue: staticHeight + extraHeight + magicNumber)
    }
    
    private var maxHeaderHeight: CGFloat { staticHeight + extraHeight }
    
    private func contentOffset(in geometry: GeometryProxy) -> CGFloat {
        min(headerHeight(in: geometry), maxHeaderHeight + geometry.safeAreaInsets.top)
    }
    
    private func headerHeight(in geometry: GeometryProxy) -> CGFloat {
        max(self.offset - magicNumber, staticHeight) + geometry.safeAreaInsets.top
    }
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                self.headerBuilder(self.headerHeight(in: geometry))
                    .frame(height: self.headerHeight(in: geometry))
                    .zIndex(2)
                
                content
                    .offset(y: self.contentOffset(in: geometry))
                    .zIndex(1)
                    .padding(.bottom, self.contentOffset(in: geometry))
            }
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { delta in
                self.offset = delta - geometry.safeAreaInsets.top
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct ScrollOffsetPreferenceKey: PreferenceKey, Equatable {
    static var defaultValue: CGFloat = 0
        
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

extension ScrollOffsetPreferenceKey: ViewModifier {
    
    func body(content: Content) -> some View {
        GeometryReader { epProxy -> AnyView in
            AnyView(
                content
                    .preference(key: ScrollOffsetPreferenceKey.self, value: epProxy.frame(in: .global).minY)
            )
        }
    }
}

struct ScrollViewExample: View {

    var body: some View {
        ScrollViewContentView()
            .modifier(StacyHeader(staticHeight: 64, extraHeight: 200, content: { desiredHeight in
                ScrollViewHeaderView(desiredHeight: desiredHeight)
            }))
    }
}

struct ScrollViewHeaderView: View {
    
    var desiredHeight: CGFloat

    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .bottom) {
                Image("catalina")
                    .resizable()
                    .aspectRatio(1, contentMode: .fill)
                    .frame(height: self.desiredHeight)
                    .clipped()
                    .opacity(Double((self.desiredHeight - 108) / 200))
                
                VStack(spacing: 4) {
                    Text("Height: \(self.desiredHeight)")
                        .bold()
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .padding()
                    Divider()
                }
                .background(Color.white)
            }
            .background(Color.white)
        }
    }
}

struct ScrollViewContentView: View {
        
    var body: some View {
        Form {
            Text("Top content")
                .modifier(ScrollOffsetPreferenceKey())
            
            Section(header: Text("0")) {
                NavigationLink(destination: DetailView(title: "Nav")) {
                    Text("Navigation link")
                }
            }
            Section(header: Text("1")) {
                NavigationLink(destination: DetailView(title: "Nav")) {
                    Text("Some navigation")
                }
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



//
//  ScrollView.swift
//  StretchyScrollApp
//
//  Created by Thomas Sivilay on 8/8/19.
//  Copyright © 2019 Thomas Sivilay. All rights reserved.
//

import SwiftUI

struct ScrollViewExample: View {
    
    @State private var maxY: CGFloat = 0
    var threshold: CGFloat = 400
    
    var body: some View {
        ScrollView {
            ScrollViewHeaderView(maxY: $maxY)
                .frame(height: maxY <= 400 ? 400 : min(maxY, 400))
//                .clipped()
            ScrollViewContentView()
        }
    }
}

struct ScrollViewHeaderView: View {
    
    @Binding var maxY: CGFloat
    
    var body: some View {
        GeometryReader { proxy -> AnyView in
            let frame = proxy.frame(in: .global)
            let height = frame.maxY
            self.maxY = height

            return AnyView(
                ZStack {
                    Image("willian-justen-de-vasconcellos")
                        .fixedSize(horizontal: true, vertical: false)
                        .frame(height: height)
                    VStack(spacing: 4) {
                        Text("Willian\nJusten de Vasconcellos")
                            .foregroundColor(.white)
                            .bold()
                            .multilineTextAlignment(.center)
                            .font(.title)
                        Text("debugFrame: \(frame.debugDescription)")
                        Text("maxY: \(self.maxY)")
                    }
                }
                .frame(width: proxy.size.width)
            )
        }
    }
}

struct ScrollViewContentView: View {
    
    var body: some View {
        GeometryReader { proxy -> AnyView in
            print(proxy)
            
            return AnyView(
                Form {
                    Text("\(proxy.size.debugDescription)")
                        .onTapGesture {
                            print("TEST")
                        }
                    Text("Row 2")
                    Text("Row 3")
                    Text("Row 4")
                    Text("Row 5")
                    Text("Row 6")
                }
                .frame(width: proxy.size.width, height: 400)
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



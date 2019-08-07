//
//  ScrollView.swift
//  StretchyScrollApp
//
//  Created by Thomas Sivilay on 8/8/19.
//  Copyright © 2019 Thomas Sivilay. All rights reserved.
//

import SwiftUI

struct ScrollViewExample: View {
    var body: some View {
        ScrollView {
            GeometryReader { reader -> AnyView in
                let frame = reader.frame(in: .global)
                let height = frame.maxY
                return AnyView(
                    ZStack {
                        Image("willian-justen-de-vasconcellos")
                            .frame(height: height, alignment: .top)
                            .clipped()
                        VStack(spacing: 4) {
                            Text("Willian\nJusten de Vasconcellos")
                                .foregroundColor(.white)
                                .bold()
                                .multilineTextAlignment(.center)
                                .font(.title)
                            Text("debugFrame: \(frame.debugDescription)")
                            Text("maxY: \(frame.maxY)")
                        }
                    }
                    .frame(width: reader.size.width)
                )
            }
            .frame(height: 400)
            
            Group {
                Text("Row 1")
                Text("Row 2")
                Text("Row 3")
                Text("Row 4")
                Text("Row 5")
                Text("Row 6")
            }
            .offset(y: 44)
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



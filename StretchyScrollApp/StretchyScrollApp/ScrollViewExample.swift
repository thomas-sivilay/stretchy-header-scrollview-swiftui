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
            Group {
                GeometryReader { reader -> AnyView in
                    let frame = reader.frame(in: .global)
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
                        .frame(width: reader.size.width)
                    )
                }
            }
            .frame(height:
                maxY <= 400 ? 400 : min(maxY, 400)
            )
            .clipped()
            
            Text("Row 1")
            Text("Row 2")
            Text("Row 3")
            Text("Row 4")
            Text("Row 5")
            Text("Row 6")
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



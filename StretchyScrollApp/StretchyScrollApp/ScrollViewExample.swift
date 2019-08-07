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



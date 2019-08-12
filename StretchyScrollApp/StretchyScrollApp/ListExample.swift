//
//  ListExample.swift
//  StretchyScrollApp
//
//  Created by Thomas Sivilay on 8/8/19.
//  Copyright © 2019 Thomas Sivilay. All rights reserved.
//

import SwiftUI

struct ListExample: View {
    
    var body: some View {
        List {
            Text("Row 1")
            Text("Row 2")
            Text("Row 3")
            Text("Row 4")
            Text("Row 5")
            Text("Row 6")
            NavigationLink(destination: DetailView(title: "Nav")) {
                Text("Navigation link")
            }
        }
    }
}

#if DEBUG
struct ListExample_Previews: PreviewProvider {
    static var previews: some View {
        ListExample()
    }
}
#endif



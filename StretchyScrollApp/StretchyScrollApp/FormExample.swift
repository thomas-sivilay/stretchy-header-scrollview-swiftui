//
//  FormTab.swift
//  StretchyScrollApp
//
//  Created by Thomas Sivilay on 8/8/19.
//  Copyright © 2019 Thomas Sivilay. All rights reserved.
//

import SwiftUI

struct FormExample: View {
    var body: some View {
        Form {
            Section(header: Text("Section 1")) {
                Text("Row 1")
                Text("Row 2")
                Text("Row 3")
                Text("Row 4")
                Text("Row 5")
            }
            Section(header: Text("Section 2")) {
                Text("Row 1")
                Text("Row 2")
            }
        }
    }
}

#if DEBUG
struct FormExample_Previews: PreviewProvider {
    static var previews: some View {
        FormExample()
    }
}
#endif


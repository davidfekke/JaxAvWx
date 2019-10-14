//
//  Airport.swift
//  JaxAvWx
//
//  Created by David Fekke on 10/12/19.
//  Copyright © 2019 David Fekke. All rights reserved.
//

import Foundation

struct Airport : Identifiable {
    var id = UUID()
    var identifier: String
    var name: String
}

#if DEBUG
let testData = [
    Airport(identifier: "KCRG", name: "Jacksonville Executive at Craig"),
    Airport(identifier: "KVQQ", name: "Cecil Field"),
    Airport(identifier: "KJAX", name: "Jacksonville Internation Airport"),
    Airport(identifier: "KHEG", name: "Herlong Regoinal Airport")
]
#endif

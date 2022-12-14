//
//  LazyView.swift
//  Twitter Clone
//
//  Created by Jacob Lucas on 9/7/22.
//

import SwiftUI

struct LazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping() -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}

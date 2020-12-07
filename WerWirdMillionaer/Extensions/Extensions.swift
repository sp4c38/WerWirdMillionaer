//
//  Extensions.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 07.12.20.
//

import SwiftUI

extension View {
    @ViewBuilder func ifTrue<Content: View>(_ condition: Bool, content: (Self) -> Content) -> some View {
        if condition {
            content(self)
        } else {
            self
        }
    }
}

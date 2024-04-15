//
//  View.swift
//  TestTask
//
//  Created by Mac on 27.03.2024.
//

import SwiftUI

extension View {
    func alert(isPresented: Binding<Bool>, message: String?, action: UndefinedAction? = nil) -> some View {
        self.alert("Error", isPresented: isPresented) {
            Button("Cancel") { action?() }
        } message: {
            Text(message ?? "Default message")
        }
    }
}

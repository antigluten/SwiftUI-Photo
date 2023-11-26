//
//  SwiftUI_TutorialApp.swift
//  SwiftUI-Tutorial
//
//  Created by va-gusev on 22.11.2023.
//

import SwiftUI

@main
struct SwiftUI_TutorialApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Model())
        }
    }
}

//
//  Prohibition_Battle_ArenaApp.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/01/06.
//

import SwiftUI

@main
struct Prohibition_Battle_ArenaApp: App {
    @StateObject private var appModel = AppModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
                .environmentObject(appModel)
                .onAppear{
                    Task {
                        await appModel.logIn()
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppModel())
    }
}

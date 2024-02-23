//
//  ContentView.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/01/06.
//

import SwiftUI
struct ContentView: View {
    @EnvironmentObject var appModel: AppModel
    var body: some View {
        //if UserDefaults.standard.object(forKey: "apiToken")の変更は検知しない。
        if !appModel.isBuilded {
            Text("データをロードしています")
        }else if appModel.isLogin {
            HomeView()
        } else {
            LoginView()
        }
    }
}
struct ContentView_preview: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppModel())
        
    }
}

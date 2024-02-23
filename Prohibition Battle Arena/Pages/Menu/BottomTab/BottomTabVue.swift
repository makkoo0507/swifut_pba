//
//  BottomTabVue.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/01/06.
//

import SwiftUI

struct BottomTabVue: View {
    init() {
//        UITabBar.appearance().backgroundColor = .green.withAlphaComponent(0.3)
        let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
//        UITabBar.appearance().standardAppearance = tabBarAppearance
    }
    var body: some View {
        TabView{
            RecordView()
                .tabItem {
                    Image(systemName: "pencil.and.list.clipboard")
                    Text("記録")
                }
            RankView()
                .tabItem {
                    Image(systemName: "star")
                    Text("ランキング")
                }
            RuleView().tabItem {
                Image(systemName: "book")
                Text("ルール")
            }
        }
    }
}

//#Preview {
//    BottomTabVue()
//}
#Preview {
    BottomTabVue()
        .environmentObject(AppModel())
}


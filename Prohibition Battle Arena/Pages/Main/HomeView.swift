//
//  SwiftUIView.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/01/06.
//

import SwiftUI

struct HomeView: View {
    @State var isMenuOpen:Bool = false
    var body: some View {
        ZStack{
            //タブ切り替え(下)
            BottomTabVue()
            //ハンバーガーメニュー(左上)
            HamburgerMenuView(isMenuOpen: $isMenuOpen)
            SideMenuView(isOpen: $isMenuOpen)
        }
    }
}

//#Preview {
//    NavigationView()
//}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(AppModel())
    }
}

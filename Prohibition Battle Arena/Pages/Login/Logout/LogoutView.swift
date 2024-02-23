//
//  Logout.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/01/30.
//

import SwiftUI

struct LogoutView: View {
    @EnvironmentObject var appModel: AppModel
    @Binding var isOpen: Bool
    var body: some View {
        VStack{
            Text("good buy, World!")
            ButtonView(
                text: "ログアウト",
                clickAction: {
                    appModel.logOut()
                },
                enableStatus: true
            )
        }
    }
}

#Preview {
    LogoutView(isOpen: Binding.constant(true))
}

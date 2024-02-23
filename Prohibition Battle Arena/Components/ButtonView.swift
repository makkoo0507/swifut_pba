//
//  ButtonView.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/02/07.
//

import SwiftUI

struct ButtonView: View {
    var text:String
    var clickAction: () async -> Void
    @State var isLoading:Bool = false
    var enableStatus: Bool
    var body: some View {
        Button(action: {
            Task {
                isLoading = true
                await clickAction()
                isLoading = false
            }
        }) {
            if(!isLoading){
                Text(text)
                    .bold()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                    .foregroundColor(Color.white)
                    .background(enableStatus ? Color.blue : Color.gray)
                    .cornerRadius(25)
            }else{
                Text("ロード中")
            }
        }
        .disabled(!enableStatus)
        .padding()
    }
}

#Preview {
    ButtonView(text: "更新する", clickAction: {}, enableStatus: false)
}

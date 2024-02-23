//
//  LoginView.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/01/30.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var appModel: AppModel
    @StateObject private var loginModel = LoginModel()
    @State var errorMessage = ""
    var body: some View {
        NavigationStack{
            VStack{
                TextField("メールアドレス", text: $loginModel.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 300)
                    .autocapitalization(.none)
                
                // 入力した文字をLoginViewModelの変数passwordに通知
                TextField("パスワード（半角英数）", text: $loginModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 300)
                    .autocapitalization(.none)
                Text(loginModel.errorMessage)
                    .foregroundColor(.red)
                ButtonView(
                    text: "ログイン",
                    clickAction: {
                        await loginModel.execLogin()
                        await appModel.logIn()
                    },
                    enableStatus: loginModel.isButtonEnabled
                )
                VStack{
                    HStack{
                        Spacer()
                        NavigationLink(
                            "アカウント作成",
                            destination: LogonView()
                        )
                        .padding()
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    }
                    .font(.system(size: 18))
                }
            }
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(AppModel())
}


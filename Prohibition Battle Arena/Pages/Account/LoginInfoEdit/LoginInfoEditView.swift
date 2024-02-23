//
//  LoginInfoEditView.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/02/03.
//

import SwiftUI

struct LoginInfoEditView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appModel: AppModel
    @StateObject private var lieModel = LoginInfoEditModel()
    var body: some View {
        VStack{
            // ログイン・連絡先 ヘッダー
            NavigatedHeader(title: "ログイン・連絡先の編集", dismissAction: {dismiss()})
            Spacer()
                    .frame(height: 30)
            //ログイン・連絡先　内容
            VStack{
                //電話番号
                HStack{
                    Text("電話番号")
                        .foregroundColor(.gray)
                        .font(.system(size: 14))
                        .padding(.leading)
                        .frame(maxWidth: 100, alignment: .leading)
                    Text("必須")
                        .foregroundColor(.red)
                        .font(.system(size: 14))
                    Spacer()
                }
                Spacer()
                    .frame(height: 5)
                TextField(
                    "電話番号を入力してください",
                    text:$lieModel.phone
                )
                    .padding(.horizontal)
                    .autocapitalization(.none)
                Divider()
                    .padding(.horizontal)
                Spacer()
                    .frame(height: 20)
                //Eメール
                HStack{
                    Text("Eメール")
                        .foregroundColor(.gray)
                        .font(.system(size: 14))
                        .padding(.leading)
                        .frame(maxWidth: 100, alignment: .leading)
                    Text("必須")
                        .foregroundColor(.red)
                        .font(.system(size: 14))
                    Spacer()
                }
                Spacer()
                    .frame(height: 5)
                TextField(
                    "Eメールを入力してください",
                    text:$lieModel.email
                )
                    .padding(.horizontal)
                    .autocapitalization(.none)
                Divider()
                    .padding(.horizontal)
                Spacer()
                    .frame(height: 20)
                //パスワード
                if(!lieModel.isChangePassword){
                    HStack{
                        Text("パスワード")
                            .foregroundColor(.gray)
                            .font(.system(size: 14))
                            .padding(.leading)
                            .frame(maxWidth: 100, alignment: .leading)
                        Spacer()
                        Button("変更する"){
                            lieModel.isChangePassword.toggle()
                        }
                        .padding()
                    }
                }else{
                    HStack{
                        Text("パスワード")
                            .foregroundColor(.gray)
                            .font(.system(size: 14))
                            .padding(.leading)
                            .frame(maxWidth: 100, alignment: .leading)
                        Text("必須")
                            .foregroundColor(.red)
                            .font(.system(size: 14))
                        Spacer()
                        Button("変更する"){
                            lieModel.isChangePassword.toggle()
                        }
                        .padding()
                    }
                    Spacer()
                        .frame(height: 5)
                    TextField("パスワードを入力してください", text:$lieModel.password
                    )
                        .padding(.horizontal)
                        .autocapitalization(.none)
                }
                Divider()
                    .padding(.horizontal)
                Spacer()
                    .frame(height: 20)
            }
            Text(lieModel.errorMessage)
            ButtonView(
                text: "更新する",
                clickAction: {
                    await lieModel.updateUser()
                    await appModel.setUser()
                },
                enableStatus: lieModel.isButtonEnabled
            )
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            lieModel.setLoginInfo(user: appModel.user)
        }
    }
}

#Preview {
    LoginInfoEditView()
        .environmentObject(AppModel())
}

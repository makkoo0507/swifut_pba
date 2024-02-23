//
//  AccountView.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/01/06.
//

import SwiftUI

struct AccountView: View {
    @Binding var isOpen: Bool
    @EnvironmentObject var appModel: AppModel
    init(isOpen:Binding<Bool>){
        self._isOpen = isOpen
    }
    var body: some View {
        NavigationStack{
            VStack{
                // アカウント情報 ヘッダー
                ModalHeaderView(isOpen: $isOpen, title: "アカウント情報")
                //アカウント情報 コンテンツ
                VStack{
                    //プロフィール タイトル
                    HStack{
                        Text("プロフィール")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .padding()
                        Spacer()
                        NavigationLink(
                            "編集",
                            destination: ProfileEditView()
                        )
                        .padding()
                    }
                    .font(.system(size: 18))
                    //プロフィール 内容
                    VStack{
                        //名前
                        Text("ひらがな氏名")
                            .foregroundColor(.gray)
                            .font(.system(size: 14))
                            .padding(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                                .frame(height: 5)
                        Text(appModel.user.name ?? "no name")
                            .padding(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                                .frame(height: 20)
                        //生年月日
                        Text("生年月日")
                            .foregroundColor(.gray)
                            .font(.system(size: 14))
                            .padding(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                                .frame(height: 5)
                        Text(appModel.user.birthday ?? "no birthday")
                            .padding(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                                .frame(height: 20)
                        //性別
                        Text("性別")
                            .foregroundColor(.gray)
                            .font(.system(size: 14))
                            .padding(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                                .frame(height: 5)
                        Text(appModel.user.sex ?? "その他")
                            .padding(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    Divider()
                    //ログイン・連絡先 タイトル
                    HStack{
                        Text("ログイン・連絡先")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .padding()
                        Spacer()
                        NavigationLink(
                            "変更",
                            destination: LoginInfoEditView()
                        )
                        .padding()
                    }
                    .font(.system(size: 18))
                    //ログイン・連絡先 内容
                    VStack{
                        //電話番号
                        Text("電話番号")
                            .foregroundColor(.gray)
                            .font(.system(size: 14))
                            .padding(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                                .frame(height: 5)
                        Text(appModel.user.phone ?? "no phone")
                            .padding(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                                .frame(height: 20)
                        //Eメール
                        Text("Eメール")
                            .foregroundColor(.gray)
                            .font(.system(size: 14))
                            .padding(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                                .frame(height: 5)
                        Text(appModel.user.email ?? "no email")
                            .padding(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                                .frame(height: 20)
                        //パスワード
                        Text("パスワード")
                            .foregroundColor(.gray)
                            .font(.system(size: 14))
                            .padding(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                                .frame(height: 5)
                        Text("●●●●●●●●")
                            .padding(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                                .frame(height: 20)
                    }
                }
                Spacer()
            }
        }
        .onAppear {
            Task {
                await appModel.setUser()
            }
        }
    }
}

#Preview {
    AccountView(isOpen: Binding.constant(true))
        .environmentObject(AppModel())
}

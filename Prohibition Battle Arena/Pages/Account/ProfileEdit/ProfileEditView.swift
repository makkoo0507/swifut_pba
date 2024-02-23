//
//  ProfileEditView.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/01/17.
//

import SwiftUI

struct ProfileEditView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appModel: AppModel
    @StateObject private var peModel = ProfileEditModel()
    var body: some View {
        VStack{
            // アカウント情報 ヘッダー
            NavigatedHeader(title: "アカウントの編集", dismissAction: {dismiss()})
            Spacer()
                    .frame(height: 30)
            //プロフィール 内容
            VStack{
                //名前
                HStack{
                    Text("ひらがな氏名")
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
                TextField("ひらがなで入力してください", text:$peModel.name)
                    .padding(.horizontal)
                    .autocapitalization(.none)
                Divider()
                    .padding(.horizontal)
                Spacer()
                    .frame(height: 20)
                //生年月日
                HStack{
                    Text("生年月日")
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
                Button(action: {
                    peModel.showBirthdayOption.toggle()
                }){
                    HStack{
                        Text(formatDate(peModel.birthday))
                            .padding(.leading)
                            .foregroundColor(Color.black)
                            .frame(maxWidth: 200, alignment: .leading)
                        Spacer()
                    }
                }
                Divider()
                    .padding(.horizontal)
                Spacer()
                    .frame(height: 20)
                //性別
                HStack{
                    Text("性別")
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
                Button(action: {
                    peModel.showSexOption.toggle()
                }){
                    HStack{
                        Text(peModel.sex)
                            .padding(.leading)
                            .foregroundColor(Color.black)
                            .frame(maxWidth: 100, alignment: .leading)
                        Spacer()
                    }
                }
                Divider()
                    .padding(.horizontal)
            }
            Text(peModel.errorMessage)
            ButtonView(
                text: "更新する",
                clickAction: {
                    await peModel.updateUser()
                    await appModel.setUser()
                },
                enableStatus: peModel.isButtonEnabled
            )
            Spacer()
        }
        .confirmationDialog("性別を選択してください", isPresented: $peModel.showSexOption){
            Button("男性"){
                peModel.sex = "男性"
            }
            Button("女性"){
                peModel.sex = "女性"
            }
            Button("その他"){
                peModel.sex = "その他"
            }
        }
        .sheet(isPresented: $peModel.showBirthdayOption){
            DatepickerView(isOpen: $peModel.showBirthdayOption, birthday: $peModel.birthday
            )
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            peModel.setObject(user: appModel.user)
        }
    }
    
}

struct ProfileEditView_preview: PreviewProvider {
    static var previews: some View {
        ProfileEditView()
            .environmentObject(AppModel())
    }
}

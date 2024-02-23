//
//  LogonView.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/02/03.
//

import SwiftUI
import Combine

struct LogonView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appModel: AppModel
    @StateObject private var logonModel = LogonModel()
    private var cancellables: Set<AnyCancellable> = []
    var body: some View {
        VStack{
            // アカウント情報 ヘッダー
            NavigatedHeader(title: "アカウントの作成", dismissAction: {dismiss()})
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
                TextField("ひらがなで入力してください", text: $logonModel.name)
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
                    logonModel.showBirthdayOption.toggle()
                }){
                    HStack{
                        Text(logonModel.birthday == nil ? "日付を選択してください" : "\(formatDate(logonModel.birthday) )")
                                .padding(.leading)
                                .foregroundColor(logonModel.birthday == nil ? Color.gray : Color.black)
                                .frame(maxWidth: 200, alignment: .leading)
                        Spacer()
                    }
                }
                Divider()
                    .padding(.horizontal)
                Spacer()
                    .frame(height: 20)
                //phone
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
                TextField("電話番号を入力してください", text: $logonModel.phone)
                    .padding(.horizontal)
                    .autocapitalization(.none)
                Divider()
                    .padding(.horizontal)
                Spacer()
                    .frame(height: 20)
                //email
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
                TextField("メールアドレスを入力してください", text: $logonModel.email)
                    .padding(.horizontal)
                    .autocapitalization(.none)
                Divider()
                    .padding(.horizontal)
                Spacer()
                    .frame(height: 20)
                //パスワード
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
                }
                Spacer()
                    .frame(height: 5)
                TextField("パスワードを入力してください", text: $logonModel.password)
                    .padding(.horizontal)
                    .autocapitalization(.none)
                Divider()
                    .padding(.horizontal)
                Spacer()
                    .frame(height: 20)
            }
            ButtonView(
                text: "作成する",
                clickAction: {
                    await logonModel.execLogon()
                    await appModel.logIn()
                },
                enableStatus: logonModel.isButtonEnabled()
            )
            Spacer()
        }
        .sheet(isPresented: $logonModel.showBirthdayOption){
            DatepickerView(isOpen: $logonModel.showBirthdayOption, birthday:Binding<Date>(
                get: { logonModel.birthday ?? Date()},
                set: { logonModel.birthday = $0 }
            ))
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    LogonView()
        .environmentObject(AppModel())
}

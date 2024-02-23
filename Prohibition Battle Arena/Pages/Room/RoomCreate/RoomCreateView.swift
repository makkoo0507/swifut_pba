//
//  RoomCreateView.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/02/06.
//

import SwiftUI

struct RoomCreateView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appModel:AppModel
    @StateObject private var rcModel = RoomCreateModel()
    var body: some View {
        VStack{
            NavigatedHeader(title: "ルームの新規作成", dismissAction:{dismiss()})
            Spacer()
                    .frame(height: 30)
            //ルームの内容
            VStack{
                //ルーム名
                HStack{
                    Text("ルーム名")
                        .foregroundColor(.gray)
                        .font(.system(size: 14))
                        .padding(.leading)
                        .frame(maxWidth: 100, alignment: .leading)
                    Spacer()
                }
                Spacer()
                    .frame(height: 5)
                TextField("ルームの名前", text: $rcModel.name)
                    .padding(.horizontal)
                    .autocapitalization(.none)
                Divider()
                    .padding(.horizontal)
                Spacer()
                    .frame(height: 20)
                //開始日
                HStack{
                    Text("バトル期間")
                        .foregroundColor(.gray)
                        .font(.system(size: 14))
                        .padding(.leading)
                        .frame(maxWidth: 100, alignment: .leading)
                    Spacer()
                }
                Spacer()
                    .frame(height: 5)
                VStack {
                    Spacer()
                        .frame(height: 20)
                    HStack{
                        DatePicker("", selection: $rcModel.start,displayedComponents: .date)
                            .labelsHidden()
                            .environment(\.locale, Locale(identifier: "ja_JP"))
                            .padding(.horizontal)
                        Spacer()
                    }
                    Spacer()
                        .frame(height: 20)
                    HStack{
                        DatePicker("", selection: $rcModel.end,displayedComponents: .date)
                            .labelsHidden()
                            .environment(\.locale, Locale(identifier: "ja_JP"))

                            .padding(.horizontal)
                        Spacer()
                    }
                }
                Divider()
                    .padding(.horizontal)
                Spacer()
                    .frame(height: 20)
                //一杯あたり
                HStack{
                    Text("一杯(350ml)あたりのペナルティー")
                        .foregroundColor(.gray)
                        .font(.system(size: 14))
                        .padding(.leading)
                    Spacer()
                }
                Spacer()
                    .frame(height: 5)
                TextField("ペナルティー", text: $rcModel.penalty)
                    .padding(.horizontal)
                    .autocapitalization(.none)
                Divider()
                    .padding(.horizontal)
                Spacer()
                    .frame(height: 20)
                //最終結果
                HStack{
                    Text("最終 罰ゲーム")
                        .foregroundColor(.gray)
                        .font(.system(size: 14))
                        .padding(.leading)
                        .frame(maxWidth: 100, alignment: .leading)
                    Spacer()
                }
                Spacer()
                    .frame(height: 5)
                VStack{
                    HStack{
                        Picker("punishment game performer", selection: $rcModel.punishment_game_performer) {
                            let performers = ["敗者","勝者","1位の者","最下位の者"]
                            ForEach(performers, id:\.self) { performer in
                                Text(performer).tag(performer)
                                }
                        }.tint(.black)
                        Text("は")
                        Picker("punishment game target", selection: $rcModel.punishment_game_target) {
                            let targets = ["敗者","勝者","1位の者","最下位の者"]
                            ForEach(targets, id:\.self) { target in
                                Text(target).tag(target)
                                }
                        }.tint(.black)
                        Text("に")
                        Spacer()
                    }
                    .padding(.horizontal, 5)
                    TextField("罰ゲームの内容", text: $rcModel.punishment_game_action)
                        .padding(.horizontal)
                        .autocapitalization(.none)
                }
                Divider()
                    .padding(.horizontal)
                Spacer()
                    .frame(height: 20)
            }
            ButtonView(
                text: "作成する",
                clickAction: {
                    let room =  await rcModel.createRoom()
                    if(room != nil){
                        await rcModel.createRoomUser(roomId: room?.id ?? 0, userId: appModel.userId)
                    }
                    await appModel.setRooms()
                    dismiss()
                },
                enableStatus: rcModel.isButtonEnabled()
            )
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    RoomCreateView()
        .environmentObject(AppModel())
}

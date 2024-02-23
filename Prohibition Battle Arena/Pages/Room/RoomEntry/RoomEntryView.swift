//
//  RoomEntryView.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/02/06.
//

import SwiftUI

struct RoomEntryView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appModel: AppModel
    @StateObject var reModel = RoomEntryModel()
    var body: some View {
        VStack{
            NavigatedHeader(title: "アカウントの作成", dismissAction: {dismiss()})
            Spacer()
                .frame(height: 100)
            //ルームアカウント
            HStack{
                Text("ルームアカウント")
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
                    .padding(.leading)
                Spacer()
            }
            Spacer()
                .frame(height: 5)
            TextField("例 @123456", text: $reModel.roomAccount)
                .padding(.horizontal)
                .autocapitalization(.none)
            Divider()
                .padding(.horizontal)
            Spacer()
                .frame(height: 20)
            ButtonView(
                text: "ルームに参加",
                clickAction: {
                    await reModel.createRoomUserByRoomAccount(userId:appModel.userId)
                    await appModel.setRooms()
                    dismiss()
                },
                enableStatus: reModel.isButtonEnabled()
            )
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
    }
}


#Preview {
    RoomEntryView()
        .environmentObject(AppModel())
}

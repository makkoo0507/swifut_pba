//
//  GroupView.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/01/27.
//

import SwiftUI

struct RoomSelectView: View {
    @Binding var isOpen:Bool
    @EnvironmentObject var appModel: AppModel
    @StateObject var rsModel = RoomSelectModel()
    init(isOpen:Binding<Bool>){
        self._isOpen = isOpen
    }
    var body: some View {
        NavigationStack{
            //        ヘッダー
            ModalHeaderView(isOpen: $isOpen, title: "ルーム")
            HStack {
                Spacer()
                NavigationLink(destination: RoomEntryView()){
                    HStack {
                        VStack{
                            Image(systemName: "arrow.down.square")
                                .font(.system(size: 30))
                            Text("Entry")
                        }
                    }
                    .foregroundColor(.black)
                }
                Spacer()
                NavigationLink(destination: RoomCreateView()){
                    HStack {
                        VStack{
                            Image(systemName: "plus.app")
                                .font(.system(size: 30))
                            Text("Create")
                        }
                    }
                    .foregroundColor(.black)
                }
                .foregroundColor(.black)
                Spacer()
            }
            .padding()
            
            List((appModel.roomList)){ room in
                Button(action: {
                    Task {
                        await rsModel.changeRoom(userId:appModel.userId,roomId:room.id ?? 0)
                        appModel.user.selected_room_id = room.id
                        await appModel.setSelectedRoom()
                        await appModel.setRoomMembers()
                    }
                }) {
                    HStack{
                        HStack{
                            Text(room.name ?? "no name")
                            Text("(\(room.room_account ?? ""))")
                        }
                        .foregroundColor(.black)
                        Spacer()
                        if room.id == appModel.user.selected_room_id {
                            Image(systemName: "checkmark")
                                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        }
                    }
                }
            }
            Spacer()
        }
    }
}

#Preview {
    RoomSelectView(isOpen:Binding.constant(true))
        .environmentObject(AppModel())
}


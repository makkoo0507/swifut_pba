//
//  RoomSelectModel.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/02/08.
//

import Foundation
class RoomSelectModel: ObservableObject {
    @Published var userApi = UserApi()
    @Published var loginApi = LoginApi()
    
    @Published var errorMessage = ""
    
    func changeRoom(userId:Int,roomId:Int) async {
        let updateUser = User(selected_room_id: roomId)
        let response = await userApi.updateUser(userId: userId, user: updateUser)
        if(response.status){
            print("選択ルームの変更が成功しました")
            DispatchQueue.main.async {
                self.errorMessage = ""
            }
        }else{
            print("選択ルームの変更が失敗しました")
            DispatchQueue.main.async {
                self.errorMessage = response.message ?? "予期せぬエラー"
            }
        }
    }
}

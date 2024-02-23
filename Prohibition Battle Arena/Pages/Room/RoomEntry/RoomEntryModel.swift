//
//  RoomEntryModel.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/02/08.
//

import Foundation
import Combine
class RoomEntryModel: ObservableObject {
    //フォーム項目
    @Published var roomAccount: String = ""
    //バリデーションステータス
    @Published var errorMessage: String = ""
    @Published var isValidRoomAccount: Bool = false
    
    @Published var roomApi = RoomApi()
    private var disposables = [AnyCancellable]()
    init(){
        $roomAccount
            .removeDuplicates()
            .map { str in
                return str.count == 7
            }
            .assign(to: &$isValidRoomAccount)
    }
    func isButtonEnabled() -> Bool {
        return isValidRoomAccount
    }
    
    func createRoomUserByRoomAccount(userId:Int) async {
        let createRoomUser =  RoomUserByRoomAccount(room_account: self.roomAccount, user_id:userId)
        let response = await roomApi.createRoomUserByRoomAccount(roomUserByRoomAccount:createRoomUser)
        if(response.status){
            print("ルームユーザーの参加に成功しました")
            DispatchQueue.main.async {
                self.errorMessage = ""
            }
        }else{
            print("ルームユーザーの参加に失敗しました")
            DispatchQueue.main.async {
                self.errorMessage = response.message ?? "予期せぬエラー"
            }
        }
    }
}

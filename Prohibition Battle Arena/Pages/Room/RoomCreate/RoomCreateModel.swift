//
//  RoomCreateModel.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/02/08.
//

import Foundation
import Combine
class RoomCreateModel: ObservableObject {
    //フォーム項目
    @Published var name: String = ""
    @Published var start: Date = Date()
    @Published var end: Date = Date()
    @Published var penalty: String = ""
    @Published var punishment_game_performer: String = "敗者"
    @Published var punishment_game_target: String = "勝者"
    @Published var punishment_game_action: String = ""
    //バリデーションステータス
    @Published var errorMessage: String = ""
    @Published var isValidName: Bool = false
    @Published var isValidStart: Bool = true
    @Published var isValidEnd: Bool = true
    @Published var isValidPenalty: Bool = false
    @Published var isValidPGPerformer: Bool = false
    @Published var isValidPGTarget: Bool = false
    @Published var isValidPGAction: Bool = false
    
    //モーダルステータス
    @Published var showBirthdayOption: Bool = false
    @Published var showSexOption: Bool = false
    
    
    @Published var roomApi = RoomApi()
    private var disposables = [AnyCancellable]()
    init(){
        $name
            .removeDuplicates()
            .map { str in
                return str.count >= 1
            }
            .assign(to: &$isValidName)
        $start
            .removeDuplicates()
            .map { selectedDate in
                return true
            }
            .assign(to: &$isValidStart)
        $end
            .removeDuplicates()
            .map { selectedDate in
                return self.start <= selectedDate
            }
            .assign(to: &$isValidEnd)
        $penalty
            .removeDuplicates()
            .map { str in
                return str.count >= 1
            }
            .assign(to: &$isValidPenalty)
        $punishment_game_performer
            .removeDuplicates()
            .map { str in
                return str.count >= 1
            }
            .assign(to: &$isValidPGPerformer)
        $punishment_game_target
            .removeDuplicates()
            .map { str in
                return str.count >= 1
            }
            .assign(to: &$isValidPGTarget)
        $punishment_game_action
            .removeDuplicates()
            .map { str in
                return str.count >= 1
            }
            .assign(to: &$isValidPGAction)
    }
    func isButtonEnabled() -> Bool {
        return isValidName && isValidStart && isValidEnd && isValidPenalty && isValidPGPerformer && isValidPGTarget && isValidPGAction
    }
    func createRoom() async -> Room? {
        let createRoom = Room(
            name: name, start: formatDate( start), end: formatDate(end), penalty: penalty, punishment_game_performer: punishment_game_performer, punishment_game_target: punishment_game_target, punishment_game_action: punishment_game_action
        )
        let response = await roomApi.createRoom(room: createRoom)
        if(response.status){
            print("ルームの作成が成功しました")
            DispatchQueue.main.async {
                self.errorMessage = ""
            }
            return response.room
        }else{
            print("ルームの作成が失敗しました")
            DispatchQueue.main.async {
                self.errorMessage = response.message ?? "予期せぬエラー"
            }
            return nil
        }
    }
    func createRoomUser(roomId:Int,userId:Int) async {
        let createRoomUser = RoomUser(room_id:roomId,user_id:userId)
        let response = await roomApi.createRoomUser(roomUser: createRoomUser)
        if(response.status){
            print("ルームユーザーの作成が成功しました")
            DispatchQueue.main.async {
                self.errorMessage = ""
            }
        }else{
            print("ルームユーザーの作成が失敗しました")
            DispatchQueue.main.async {
                self.errorMessage = response.message ?? "予期せぬエラー"
            }
        }
    }
}

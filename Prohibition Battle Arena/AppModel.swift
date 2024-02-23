//
//  AppModel.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/01/30.
//

import Foundation
class AppModel: ObservableObject {
    @Published var isBuilded:Bool = false
    @Published var isLogin:Bool = false
    @Published var userId:Int = 0
//    @Published var roomId:Int = 0
    @Published var userApi = UserApi()
    @Published var user: User = User()
    @Published var roomApi = RoomApi()
    @Published var roomList: [Room] = [Room()]
    @Published var selectedRoom: Room = Room()
    @Published var roomMembers: [User] = [User()]
    init(){
    }
    func logIn() async{
        if let apiToken = UserDefaults.standard.object(forKey: "apiToken") as? Int {
            DispatchQueue.main.async {
                self.userId = apiToken
                Task {
                    self.isBuilded = true
                    self.isLogin = true
                    await self.setUser()
                    await self.setRooms()
                    await self.setSelectedRoom()
                    await self.setRoomMembers()
                }
            }
        }
    }
    
    func logOut(){
        isLogin = false
        userId = 0
//        roomId = 0
        unsetUser()
        unsetRooms()
        unsetSelectedRoom()
        unsetRoomMembers()
    }
    func setUser() async {
        let response = await userApi.getUser(userId: userId)
        if(response.status){
            DispatchQueue.main.async {
                self.user = response.user ?? User()
            }
        }
    }
    func unsetUser(){
        self.user = User()
    }
    // rooms
    func setRooms()async{
        let response = await roomApi.getRoomsByUserId(userId:userId)
        if(response.status){
            DispatchQueue.main.async {
                self.roomList = response.rooms ?? [Room()]
            }
        }
    }
    func unsetRooms(){
        self.roomList = [Room()]
    }
    // selectedRoom
    func setSelectedRoom() async {
        let response = await roomApi.getRoomById(id:self.user.selected_room_id ?? 0)
        if(response.status){
            DispatchQueue.main.async {
                self.selectedRoom = response.room ?? Room()
            }
        }
    }
    func unsetSelectedRoom(){
        self.selectedRoom = Room()
    }
    // roomMembers
    func setRoomMembers() async {
        let response = await roomApi.getRoomMembers(roomId:self.user.selected_room_id ?? 0)
        if(response.status){
            DispatchQueue.main.async {
                self.roomMembers = response.users ?? [User()]
            }
        }
    }
    func unsetRoomMembers(){
        self.roomMembers = [User()]
    }
}


struct User: Codable {
    var id: Int?
    var name: String?
    var phone: String?
    var birthday: String?
    var sex: String?
    var selected_room_id: Int?
    var email: String?
    var password: String?
    var email_verified_at: String?
    var created_at: String?
    var updated_at: String?
    var deleted_at: String?
}

struct Room:  Identifiable, Codable {
    var id: Int?
    var room_account: String?
    var name: String?
    var start: String?
    var end: String?
    var penalty: String?
    var punishment_game_performer: String?
    var punishment_game_target: String?
    var punishment_game_action: String?
    var created_at: String?
    var updated_at: String?
    var deleted_at: String?
}

struct RoomUser:  Identifiable, Codable {
    var id: Int?
    var room_id: Int?
    var user_id: Int?
}

struct RoomUserByRoomAccount: Codable {
    var id: Int?
    var room_account: String?
    var user_id: Int?
}

struct Record: Codable {
    var id: Int?
    var user_id: Int?
    var room_id: Int?
    var date: String?
    var type: String?
    var amount: Int?
    var memo: String?
    var created_at: String?
    var updated_at: String?
    var deleted_at: String?
}

struct Rank: Codable {
    var user_id:Int?
    var user_name:String?
    var rank:Int?
    var amount:Int?
}

//
//  RoomApi.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/02/05.
//
import Foundation
class RoomApi: ObservableObject {
    func getRoomById(id:Int) async -> RoomResponse {
        guard let url = URL(string: "http://localhost:8000/api/rooms/\(id)") else {
            return RoomResponse(status: false, message: apiErrorMessage.urlError)
        }
        let request = URLRequest(url: url)
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedResponse = try JSONDecoder().decode(RoomResponse.self, from: data)
            if(decodedResponse.status){
                return RoomResponse(status: true,room: decodedResponse.room)
            }else{
                return RoomResponse(status: false, message: decodedResponse.message)
            }
        } catch {
            print("ルーム取得の失敗: \(error.localizedDescription)")
            return RoomResponse(status: false,message: apiErrorMessage.networkError)
        }
    }
    
    func getRoomsByUserId(userId:Int) async -> RoomsResponse {
        guard let url = URL(string: "http://localhost:8000/api/users/\(userId)/rooms") else {
            return RoomsResponse(status: false, message: apiErrorMessage.urlError)
        }
        let request = URLRequest(url: url)
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedResponse = try JSONDecoder().decode(RoomsResponse.self, from: data)
            if(decodedResponse.status){
                return RoomsResponse(status: true,rooms: decodedResponse.rooms)
            }else{
                return RoomsResponse(status: false, message: decodedResponse.message)
            }
        } catch {
            print("ルーム取得の失敗: \(error.localizedDescription)")
            return RoomsResponse(status: false,message: apiErrorMessage.networkError)
        }
    }
    
    func createRoom(room:Room) async -> RoomResponse {
        guard let url = URL(string: "http://localhost:8000/api/rooms/") else {
            return RoomResponse(status: false, message: apiErrorMessage.urlError)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let jsonData = try JSONEncoder().encode([room])
            request.httpBody = jsonData
        } catch {
            print("JSON encode エラー: \(error)")
            return RoomResponse(status: false,message: apiErrorMessage.encodeError)
        }
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedResponse = try JSONDecoder().decode(RoomsResponse.self, from: data)
            if(decodedResponse.status){
                return RoomResponse(status: true,room: decodedResponse.rooms?[0])
            }else{
                return RoomResponse(status: false, message: decodedResponse.message)
            }
        } catch {
            print("ルーム作成の失敗: \(error.localizedDescription)")
            return RoomResponse(status: false,message: apiErrorMessage.networkError)
        }
    }
    func createRoomUser(roomUser:RoomUser) async -> RoomUserResponse {
        guard let url = URL(string: "http://localhost:8000/api/room_users/") else {
            return RoomUserResponse(status: false, message: apiErrorMessage.urlError)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let jsonData = try JSONEncoder().encode([roomUser])
            request.httpBody = jsonData
        } catch {
            print("JSON encode エラー: \(error)")
            return RoomUserResponse(status: false,message: apiErrorMessage.encodeError)
        }
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedResponse = try JSONDecoder().decode(RoomUserResponse.self, from: data)
            if(decodedResponse.status){
                return RoomUserResponse(status: true,message: "")
            }else{
                return RoomUserResponse(status: false, message: decodedResponse.message)
            }
        } catch {
            print("ルーム作成の失敗: \(error.localizedDescription)")
            return RoomUserResponse(status: false,message: apiErrorMessage.networkError)
        }
    }
    func createRoomUserByRoomAccount( roomUserByRoomAccount: RoomUserByRoomAccount) async -> RoomUserResponse {
        guard let url = URL(string: "http://localhost:8000/api/room_users/by_room_account") else {
            return RoomUserResponse(status: false, message: apiErrorMessage.urlError)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let jsonData = try JSONEncoder().encode( roomUserByRoomAccount)
            request.httpBody = jsonData
        } catch {
            print("JSON encode エラー: \(error)")
            return RoomUserResponse(status: false,message: apiErrorMessage.encodeError)
        }
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedResponse = try JSONDecoder().decode(RoomUserResponse.self, from: data)
            if(decodedResponse.status){
                return RoomUserResponse(status: true,message: "")
            }else{
                return RoomUserResponse(status: false, message: decodedResponse.message)
            }
        } catch {
            print("ルーム作成の失敗: \(error.localizedDescription)")
            return RoomUserResponse(status: false,message: apiErrorMessage.networkError)
        }
    }
    
    func getRoomMembers(roomId:Int) async -> UsersResponse {
        guard let url = URL(string: "http://localhost:8000/api/rooms/\(roomId)/users") else {
            return UsersResponse(status: false, message: apiErrorMessage.urlError)
        }
        let request = URLRequest(url: url)
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedResponse = try JSONDecoder().decode(UsersResponse.self, from: data)
            if(decodedResponse.status){
                return UsersResponse(status: true,users: decodedResponse.users)
            }else{
                return UsersResponse(status: false, message: decodedResponse.message)
            }
        } catch {
            print("ルームメンバーの取得の失敗: \(error.localizedDescription)")
            return UsersResponse(status: false,message: apiErrorMessage.networkError)
        }
    }
}

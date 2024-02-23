//
//  ApiResponse.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/02/09.
//

struct UserResponse: Codable {
    var status: Bool
    var user: User?
    var message: String?
}

struct UsersResponse: Codable {
    var status: Bool
    var users: [User]?
    var message: String?
}


struct RoomResponse: Codable {
    var status: Bool
    var room: Room?
    var message: String?
}
struct RoomsResponse: Codable {
    var status: Bool
    var rooms: [Room]?
    var message: String?
}
struct RoomUserResponse: Codable {
    var status: Bool
    var message: String?
}

struct RecordResponse: Codable {
    var status: Bool
    var records: [Record]?
    var message: String?
}

struct RanksResponse: Codable {
    var status: Bool
    var ranks: [Rank]?
    var message: String?
}


struct LoginResponse: Codable {
    var status: Bool
    var user: User?
    var message: String?
}


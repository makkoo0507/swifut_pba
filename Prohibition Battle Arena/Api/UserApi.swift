//
//  userApi.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/02/04.
//

import Foundation
class UserApi: ObservableObject {
    
    func getUser(userId:Int) async -> UserResponse {
        guard let url = URL(string: "http://localhost:8000/api/users/\(userId)") else {
            return UserResponse(status: false,message: apiErrorMessage.urlError)
        }
        let request = URLRequest(url: url)
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedResponse = try JSONDecoder().decode(UserResponse.self, from: data)
            if(decodedResponse.status){
                return UserResponse(status: true,user: decodedResponse.user)
            }else{
                return UserResponse(status: false, message: decodedResponse.message)
            }
        } catch {
            print("ユーザーの取得の失敗: \(error.localizedDescription)")
            return UserResponse(status: false,message: apiErrorMessage.networkError)
        }
    }

    func updateUser(userId: Int, user: User) async -> UsersResponse {
        guard let url = URL(string: "http://localhost:8000/api/users/\(userId)") else {
            return UsersResponse(status: false,message: apiErrorMessage.urlError)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"

        do {
            let jsonData = try JSONEncoder().encode(user)
            request.httpBody = jsonData
        } catch {
            print("JSON encode エラー: \(error)")
            return UsersResponse(status: false,message: apiErrorMessage.encodeError)
        }

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedResponse = try JSONDecoder().decode(UserResponse.self, from: data)
            if(decodedResponse.status){
                return UsersResponse(status: true,message: decodedResponse.message)
            }else{
                return UsersResponse(status: false,message: decodedResponse.message)
            }
        } catch {
            print("Login failed: \(error.localizedDescription)")
            return UsersResponse(status: false,message: apiErrorMessage.networkError)
        }
    }
    
    func createUser(user: User) async -> UserResponse {
        guard let url = URL(string: "http://localhost:8000/api/users") else {
            return UserResponse(status: false,message: apiErrorMessage.urlError)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        do {
            let jsonData = try JSONEncoder().encode([user])
            request.httpBody = jsonData
        } catch {
            print("JSON encode エラー: \(error)")
            return UserResponse(status: false,message: apiErrorMessage.encodeError)
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedResponse = try JSONDecoder().decode(UsersResponse.self, from: data)
            if(decodedResponse.status){
                let user = decodedResponse.users?[0]
                return UserResponse(status: true,user: user)
            }else{
                return UserResponse(status: false,message: decodedResponse.message)
            }
        } catch {
            print("ユーザの作成失敗: \(error.localizedDescription)")
            return UserResponse(status: false,message: apiErrorMessage.networkError)
        }
    }
    //    func getUser(userId:Int,completion: @escaping (User?) -> Void) {
    //        guard let url = URL(string: "http://localhost:8000/api/users/\(userId)") else {
    //            completion(nil)
    //            return
    //        }
    //        let request = URLRequest(url: url)
    //        URLSession.shared.dataTask(with: request) { data, response, error in
    //            if let data = data {
    //                do {
    //                    let decodedResponse = try JSONDecoder().decode(UserResponse.self, from: data)
    //                    let user = decodedResponse.user
    //                    completion(user)
    //                } catch {
    //                    print("JSON decode エラー: \(error)")
    //                    completion(nil)
    //                }
    //            } else if let error = error {
    //                print("Fetch failed: \(error.localizedDescription)")
    //                completion(nil)
    //            } else {
    //                completion(nil)
    //            }
    //        }.resume()
    //    }

}

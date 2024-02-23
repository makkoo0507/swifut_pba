//
//  LoginApi.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/02/05.
//

import Foundation
class LoginApi: ObservableObject {
    func execLogin(email: String, password: String) async -> LoginResponse {
        guard let url = URL(string: "http://localhost:8000/api/login") else {
            return LoginResponse(status: false,message: apiErrorMessage.urlError)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let body = RequestBody(
            email: email,
            password: password
        )
        do {
            let jsonData = try JSONEncoder().encode(body)
            request.httpBody = jsonData
        } catch {
            print("JSON encode エラー: \(error)")
            return LoginResponse(status: false,message: apiErrorMessage.encodeError)
        }
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
            if(decodedResponse.status){
                let user = decodedResponse.user
                return LoginResponse(status: true,user: user)
            }else{
                return LoginResponse(status: false,message: decodedResponse.message)
            }
        } catch {
            print("Login failed: \(error.localizedDescription)")
            return LoginResponse(status: false,message: apiErrorMessage.networkError)
        }
    }
}

struct RequestBody: Codable {
    var email: String
    var password: String
}

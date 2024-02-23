//
//  RecordApi.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/02/12.
//

import Foundation
class RecordApi: ObservableObject {
    func getRecord(userId:Int,roomId:Int,year:Int,month:Int) async ->
    RecordResponse {
        let baseURLString = "http://localhost:8000/api/records/"
        guard let url = URL(string: "\(baseURLString)\(userId)/\(roomId)") else {
            return RecordResponse(status: false, message: apiErrorMessage.urlError)
        }

        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.queryItems = [URLQueryItem(name: "year", value: String(year)),
                                 URLQueryItem(name: "month", value: String(month))]
        guard let finalURL = components.url else {
            return RecordResponse(status: false, message: apiErrorMessage.urlError)
        }
        
        var request = URLRequest(url: finalURL)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedResponse = try JSONDecoder().decode(RecordResponse.self, from: data)
            if(decodedResponse.status){
                return RecordResponse(status: true,records: decodedResponse.records)
            }else{
                return RecordResponse(status: false, message: decodedResponse.message)
            }
        } catch {
            print("レコードの取得の失敗: \(error.localizedDescription)")
            return RecordResponse(status: false,message: apiErrorMessage.networkError)
        }
    }
    func createRecord(record:Record) async -> RecordResponse {
        guard let url = URL(string: "http://localhost:8000/api/records/") else {
            return RecordResponse(status: false, message: apiErrorMessage.urlError)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let jsonData = try JSONEncoder().encode([record])
            request.httpBody = jsonData
        } catch {
            print("JSON encode エラー: \(error)")
            return RecordResponse(status: false,message: apiErrorMessage.encodeError)
        }
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedResponse = try JSONDecoder().decode(RecordResponse.self, from: data)
            if(decodedResponse.status){
                return RecordResponse(status: true,message: "")
            }else{
                return RecordResponse(status: false, message: decodedResponse.message)
            }
        } catch {
            print("レコード作成の失敗: \(error.localizedDescription)")
            return RecordResponse(status: false,message: apiErrorMessage.networkError)
        }
    }
    func updateRecord(record:Record) async -> RecordResponse {
        guard let url = URL(string: "http://localhost:8000/api/records/\(record.id ?? 0)") else {
            return RecordResponse(status: false, message: apiErrorMessage.urlError)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let jsonData = try JSONEncoder().encode(record)
            request.httpBody = jsonData
        } catch {
            print("JSON encode エラー: \(error)")
            return RecordResponse(status: false,message: apiErrorMessage.encodeError)
        }
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedResponse = try JSONDecoder().decode(RecordResponse.self, from: data)
            if(decodedResponse.status){
                return RecordResponse(status: true,message: "")
            }else{
                return RecordResponse(status: false, message: decodedResponse.message)
            }
        } catch {
            print("レコード作成の失敗: \(error.localizedDescription)")
            return RecordResponse(status: false,message: apiErrorMessage.networkError)
        }
    }
    func deleteRecord(record:Record) async -> RecordResponse {
        guard let url = URL(string: "http://localhost:8000/api/records/\(record.id ?? 0)") else {
            return RecordResponse(status: false, message: apiErrorMessage.urlError)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let jsonData = try JSONEncoder().encode(record)
            request.httpBody = jsonData
        } catch {
            print("JSON encode エラー: \(error)")
            return RecordResponse(status: false,message: apiErrorMessage.encodeError)
        }
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedResponse = try JSONDecoder().decode(RecordResponse.self, from: data)
            if(decodedResponse.status){
                return RecordResponse(status: true,message: "")
            }else{
                return RecordResponse(status: false, message: decodedResponse.message)
            }
        } catch {
            print("レコード削除の失敗: \(error.localizedDescription)")
            return RecordResponse(status: false,message: apiErrorMessage.networkError)
        }
    }
    func getRanksOfRoom(roomId:Int) async -> RanksResponse {
        guard let url = URL(string: "http://localhost:8000/api/rooms/\(roomId)/records/ranks") else {
            return RanksResponse(status: false, message: apiErrorMessage.urlError)
        }
        let request = URLRequest(url: url)
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedResponse = try JSONDecoder().decode(RanksResponse.self, from: data)
            if(decodedResponse.status){
                return RanksResponse(status: true,ranks: decodedResponse.ranks)
            }else{
                return RanksResponse(status: false, message: decodedResponse.message)
            }
        } catch {
            print("ランクの取得の失敗: \(error.localizedDescription)")
            return RanksResponse(status: false,message: apiErrorMessage.networkError)
        }
    }
}
struct RecordRequestBody: Codable {
    var year: Int
    var month: Int
}

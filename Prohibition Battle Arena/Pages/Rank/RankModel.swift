//
//  RankModel.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/02/17.
//

import Foundation
class RankModel: ObservableObject {
    @Published var isLogin:Bool = false
    @Published var rankList:[Rank] = [Rank()]
    @Published var recordApi = RecordApi()
    init(){
    }
    func setRanks(roomId:Int)async{
        let response = await recordApi.getRanksOfRoom(roomId: roomId)
        if(response.status){
            DispatchQueue.main.async {
                self.rankList = response.ranks ?? [Rank()]
            }
        }
    }
}


//
//  RuleModel.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/02/09.
//

import Foundation
class RuleModel: ObservableObject {
    @Published var roomApi = RoomApi()
    @Published var errorMessage = ""
}

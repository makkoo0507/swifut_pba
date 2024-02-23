//
//  EditRecordModel.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/02/16.
//

import Foundation
import Foundation
import Combine
class EditRecordModel: ObservableObject {
    @Published var selectedRecord:Record
    //バリデーションステータス
    @Published var isButtonEnabled: Bool = false
    @Published var errorMessage: String = ""
    
    @Published var recordApi = RecordApi()
    private var disposables = [AnyCancellable]()
    init(selectedRecord:Record){
        self.selectedRecord = selectedRecord
    
        $selectedRecord
            .map{ record in
                return record.amount ?? 0 > 0
            }
            .assign(to: &$isButtonEnabled)
    }
    func unsetItems(){
        selectedRecord = Record()
    }
    func updateRecord() async {
        let updateRecord = selectedRecord
        let response = await recordApi.updateRecord(record: updateRecord)
        if(response.status){
            print("レコードの更新が成功しました")
            DispatchQueue.main.async {
                self.errorMessage = ""
            }
        }else{
            print("レコードの更新が失敗しました")
            DispatchQueue.main.async {
                self.errorMessage = response.message ?? "予期せぬエラー"
            }
        }
    }
    func deleteRecord() async {
        let deleteRecord = selectedRecord
        let response = await recordApi.deleteRecord(record: deleteRecord)
        if(response.status){
            print("レコードの削除が成功しました")
            DispatchQueue.main.async {
                self.errorMessage = ""
            }
        }else{
            print("レコードの削除に失敗しました")
            DispatchQueue.main.async {
                self.errorMessage = response.message ?? "予期せぬエラー"
            }
        }
    }
    
    
    
    func calcTotalAmont(list:[Record])->Int{
        var total = 0
        for record in list {
            total += record.amount ?? 0
        }
        return total
    }
}

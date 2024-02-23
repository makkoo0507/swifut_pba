//
//  AddNewRecordModel.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/02/14.
//

import Foundation
import Combine
class AddNewRecordModel: ObservableObject {
    @Published var calendarDates:[CalendarStringDates] = []
    @Published var year: Int
    @Published var month: Int
    @Published var newRecordType:String
    @Published var newRecordDate:String = formatDate(Date())
    @Published var newRecordAmount:Int?
    //バリデーションステータス
    @Published var isValidType: Bool = false
    @Published var isValidDate: Bool = false
    @Published var isValidAmount: Bool = false
    @Published var isButtonEnabled: Bool = false
    @Published var errorMessage: String = ""
    
    @Published var recordApi = RecordApi()
    private var disposables = [AnyCancellable]()
    init(year:Int,month:Int,type:String){
        self.year = year
        self.month = month
        calendarDates = getCalendarDates(year: year, month: month)
        self.newRecordType = type
        
        $newRecordType
            .removeDuplicates()
            .map{ str in
                return str.count >= 1
            }
            .assign(to: &$isValidType)
        $newRecordDate
            .removeDuplicates()
            .map{ str in
                return str.count >= 1
            }
            .assign(to: &$isValidDate)
        $newRecordAmount
            .removeDuplicates()
            .map{ int in
                return int ?? 0 > 0
            }
            .assign(to: &$isValidAmount)
        Publishers.CombineLatest3($isValidType, $isValidDate, $isValidAmount)
            .map { isValidType, isValidDate, isValidAmount in
                return isValidType && isValidDate && isValidAmount
            }
            .assign(to: &$isButtonEnabled)
    }
    func unsetItems(){
        newRecordType = ""
        newRecordDate = formatDate(Date())
        newRecordAmount = 0
    }
    
    func createRecord(userId:Int,roomId:Int) async {
        let createRecord = Record(user_id:userId,room_id:roomId,date: newRecordDate,type: newRecordType,amount: newRecordAmount)
        let response = await recordApi.createRecord(record: createRecord)
        if(response.status){
            print("レコードの作成が成功しました")
            DispatchQueue.main.async {
                self.errorMessage = ""
            }
        }else{
            print("レコードの作成が失敗しました")
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

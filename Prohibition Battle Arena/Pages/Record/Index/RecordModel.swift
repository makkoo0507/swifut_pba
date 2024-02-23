//
//  RecodeModel.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/02/10.
//

import Foundation
class RecordModel: ObservableObject {
    @Published var year: Int = Calendar.current.component(.year, from: Date())
    @Published var month: Int = Calendar.current.component(.month, from: Date())
//    @Published var isLogin:Bool = false
    @Published var recordsOfThisMonth: [Record] = [Record()]
    @Published var summaryOfThisMonth: [Record] = [Record()]
    @Published var recordsOfDate: [String:[Record]] = ["":[Record()]]
    @Published var summaryLists: [String:Int] = ["":0]
    @Published var recordApi = RecordApi()
    
    func unsetObject(){
        DispatchQueue.main.async {
            self.recordsOfThisMonth = [Record()]
            self.summaryOfThisMonth = [Record()]
            self.recordsOfDate = ["":[Record()]]
            self.summaryLists = ["":0]
        }
    }
    //recordsOfThisMonth
    func setRecordsOfThisMonth(userId:Int,roomId:Int) async {
        let response = await recordApi.getRecord(userId:userId,roomId:roomId,year:year,month:month)
        if(response.status){
            DispatchQueue.main.async {
                self.recordsOfThisMonth = response.records ?? [Record()]
            }
        }
    }
    
    func setSummaryOfThisMonth() {
        var summary = [String: Int]()
        for record in recordsOfThisMonth {
            if let type = record.type, let amount = record.amount {
                summary[type] = (summary[type] ?? 0) + amount
            }
        }
        DispatchQueue.main.async {
            self.summaryOfThisMonth = summary.map {
                Record(type: $0.key, amount: $0.value)
            }
        }
    }
    func setRecordsOfDateAndSummaryLists() {
        var groupedRecords = [String: [Record]]()
        for record in recordsOfThisMonth {
            if let dateString = record.date {
                let date = String(dateString)
                if var recordsForDate = groupedRecords[date] {
                    recordsForDate.append(record)
                    groupedRecords[date] = recordsForDate
                } else {
                    groupedRecords[date] = [record]
                }
            }
        }
        DispatchQueue.main.async {
            self.recordsOfDate = groupedRecords
        }
        var summaryLists = [String: Int]()
        for (date, records) in groupedRecords {
            summaryLists[date] = calcTotalAmont(list: records)
        }
        DispatchQueue.main.async {
            self.summaryLists = summaryLists
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

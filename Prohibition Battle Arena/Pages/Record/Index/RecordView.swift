//
//  RecodeView.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/02/09.
//

import SwiftUI

struct RecordView: View {
    @State var selectedRecord:Record = Record()
    @State var showNewRecordModal:Bool = false
    @State var showEditRecordModal:Bool = false
    @State var newRecprdType:String = ""
    @EnvironmentObject var appModel:AppModel
    @ObservedObject var recordModel = RecordModel()
    var drinks = ["ビール","日本酒","酎ハイ","ワイン","その他"]
    let columns: [GridItem] = Array(repeating: .init(.fixed(50)), count: 2)
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                HeadMonthPickerView(year: $recordModel.year, month: $recordModel.month)
                HStack{
                    ScrollView{
                        SummaryListingView(year: recordModel.year, month: recordModel.month,lists: recordModel.summaryLists)
                    }
                    VStack(alignment: .leading){
                        MonthlyRecordView(
                            isEditOpen: $showEditRecordModal, 
                            summary: $recordModel.summaryOfThisMonth,
                            recordsOfDate:  $recordModel.recordsOfDate,
                            selectedRecord: $selectedRecord
                        )
                        ScrollView(.horizontal){
                            HStack{
                                ForEach(drinks,id:\.self){ drink in
                                    VStack{
                                        Button(action: {
                                            newRecprdType = drink
                                            showNewRecordModal = true
                                        }){
                                            Image(drink)
                                                .resizable()
                                                .frame(width: 30, height: 40)
                                            Text(drink)
                                                .font(.system(size: 14))
                                        }
                                    }.padding(.horizontal,7)
                                }
                            }
                        }
                        Spacer()
                    }
                }
            }
            .onAppear{
                Task{
                    if(!showNewRecordModal){
                        await recordModel.setRecordsOfThisMonth(userId: appModel.userId, roomId: appModel.selectedRoom.id ?? 0)
                        recordModel.setSummaryOfThisMonth()
                        recordModel.setRecordsOfDateAndSummaryLists()
                    }
                }
            }
            .onChange(of: appModel.selectedRoom.id) {
                Task {
                    if !showNewRecordModal {
                        await recordModel.setRecordsOfThisMonth(userId: appModel.userId, roomId: appModel.selectedRoom.id ?? 0)
                        recordModel.setSummaryOfThisMonth()
                        recordModel.setRecordsOfDateAndSummaryLists()
                    }
                }
            }
            .onChange(of: showNewRecordModal) {
                Task {
                    if !showNewRecordModal {
                        await recordModel.setRecordsOfThisMonth(userId: appModel.userId, roomId: appModel.selectedRoom.id ?? 0)
                        recordModel.setSummaryOfThisMonth()
                        recordModel.setRecordsOfDateAndSummaryLists()
                    }
                }
            }
            .onChange(of: showEditRecordModal) {
                Task {
                    if !showEditRecordModal {
                        await recordModel.setRecordsOfThisMonth(userId: appModel.userId, roomId: appModel.selectedRoom.id ?? 0)
                        recordModel.setSummaryOfThisMonth()
                        recordModel.setRecordsOfDateAndSummaryLists()
                    }
                }
            }
            .onChange(of: recordModel.year) {
                Task {
                    await recordModel.setRecordsOfThisMonth(userId: appModel.userId, roomId: appModel.selectedRoom.id ?? 0)
                    recordModel.setSummaryOfThisMonth()
                    recordModel.setRecordsOfDateAndSummaryLists()
                }
            }
            .onChange(of: recordModel.month) {
                Task {
                    await recordModel.setRecordsOfThisMonth(userId: appModel.userId, roomId: appModel.selectedRoom.id ?? 0)
                    recordModel.setSummaryOfThisMonth()
                    recordModel.setRecordsOfDateAndSummaryLists()
                }
            }
            //モーダル
            if(showNewRecordModal){
                AddNewRecordView(isOpen:$showNewRecordModal, year: recordModel.year, month: recordModel.month,type: newRecprdType)
            }
            if(showEditRecordModal){
                EditRecordView(isOpen:$showEditRecordModal,selectedRecord: $selectedRecord)
            }
        }
    }
}



#Preview {
    RecordView()
        .environmentObject(AppModel())
}

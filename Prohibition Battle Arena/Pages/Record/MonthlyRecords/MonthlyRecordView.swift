//
//  MonthlyRecordView.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/02/11.
//

import SwiftUI

struct MonthlyRecordView: View {
    @Binding var isEditOpen:Bool
    @Binding var summary:[Record]
    @Binding var recordsOfDate:[String:[Record]]
    @Binding var selectedRecord:Record
    @StateObject var recordModel = RecordModel()
    let list:[Record] = [ Record(id:1,type:"ビール",amount: 350),Record(id:2,type:"ワイン",amount: 450) ]
    
    var body: some View {
        ScrollView(.horizontal){
            HStack{
                ForEach(summary,id:\.self.type){ record in
                    HStack{
                        Image(record.type ?? "")
                            .resizable()
                            .frame(width: 15, height: 20)
                        Text("\(record.amount ?? 0) ml")
                            .font(.system(size: 14))
                    }.padding(.horizontal,7)
                }
            }
            .padding()
        }
        Divider()
        List{
            ForEach(recordsOfDate.sorted(by: { $0.key < $1.key }), id: \.key){ (date, records) in
                VStack(alignment: .leading){
                    Text("\(getDay(date)) 日：\(recordModel.calcTotalAmont(list: records))ml")
                    ForEach(records, id: \.self.id) { recode in
                        HStack {
                            Image(recode.type ?? "")
                                .resizable()
                                .frame(width: 20, height: 30)
                                .padding(.leading)
                            Text(": \(recode.amount ?? 0) ml")
                            Spacer()
                        }
                        .onTapGesture {
                            selectedRecord = recode
                            isEditOpen = true
                        }
                    }
                }
            }
        }
        .listStyle(PlainListStyle())
    }
}

#Preview {
    MonthlyRecordView(
        isEditOpen:Binding.constant(false), summary: Binding.constant(
            [ Record(id:1,type:"ビール",amount: 2500),Record(id:2,type:"ワイン",amount: 1050) ]
        ),
        recordsOfDate: Binding.constant(
            [
                "2024-02-10":[Record(id:1,type:"ビール",amount: 350),Record(id:2,type:"ワイン",amount: 450)],
                "2024-02-11":[Record(id:1,type:"ビール",amount: 350),Record(id:2,type:"ワイン",amount: 450)]
            ]
        ),
        selectedRecord: Binding.constant(Record())
    )
}

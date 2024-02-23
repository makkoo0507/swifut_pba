//
//  AddNewRecordView.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/02/14.
//

import SwiftUI

struct AddNewRecordView: View {
    @EnvironmentObject var appModel:AppModel
    @Binding var isOpen:Bool
    var year:Int
    var month:Int
    var type:String
    @StateObject var anrModel: AddNewRecordModel
    init(isOpen:Binding<Bool>,year: Int, month: Int,type:String) {
        self._isOpen = isOpen
        self.year = year
        self.month = month
        self.type = type
        self._anrModel = StateObject(wrappedValue: AddNewRecordModel(year: year, month: month,type: type))
    }
    var body: some View {
        ZStack{
            
            Color.black
                .edgesIgnoringSafeArea(.all)
                .opacity(0.2)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isOpen = false
                    }
                }
            VStack{
                //タイトル
                HStack{
                    Image(type)
                        .resizable()
                        .frame(width: 30, height: 40)
                    Spacer()
                    Text(type)
                        .font(.largeTitle)
                    Spacer()
                    Image(type)
                        .resizable()
                        .frame(width: 30, height: 40)
                }
                .padding()
                .foregroundColor(Color(UIColor.label)) // テキストのカラーを設定
                .background(Color(UIColor.systemBackground))
                //日付選択
                VStack{
                    Text("日付選択")
                        .font(.title)
//                        Text("\(recordModel.newRecordDate)")
                    Picker(selection: $anrModel.newRecordDate, label: Text("")) {
                        ForEach(anrModel.calendarDates) { calendarDate in
                            if let date = calendarDate.date {
                                Text("\(String(date.dropFirst(8))) 日").tag(date)
                            } else {
                                Text("No date available")
                            }
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 150)
                }
                .padding()
                .foregroundColor(Color(UIColor.label))
                .background(Color(UIColor.systemBackground))
                HStack{
                    Spacer()
                    TextField("量を入力",value:$anrModel.newRecordAmount, format:.number )
                        .multilineTextAlignment(TextAlignment.trailing)
                        .frame(width: 80)
                    Text("ml")
                    Spacer()
                }
                .padding()
                .foregroundColor(Color(UIColor.label))
                .background(Color(UIColor.systemBackground))
                //ok
                ButtonView(
                    text: "OK",
                    clickAction: {
                        await anrModel.createRecord(userId:appModel.userId , roomId: appModel.selectedRoom.id!)
                    },
                    enableStatus: anrModel.isButtonEnabled
                )
                .padding()
                .background(Color(UIColor.systemBackground))
                //キャンセル
                HStack{
                    
                    Button(action: {
                        anrModel.unsetItems()
                        isOpen = false
                    }){
                        Spacer()
                        Text("キャンセル")
                            .font(.system(size: 22))
                        Spacer()
                    }
                }
                .padding()
                .foregroundColor(.red)
                .background(Color(UIColor.systemBackground))
                
            }
            .padding()
        }
    }
}

#Preview {
    AddNewRecordView(isOpen:Binding.constant(true), year:2024,month: 2,type: "ビール")
        .environmentObject(AppModel())
}

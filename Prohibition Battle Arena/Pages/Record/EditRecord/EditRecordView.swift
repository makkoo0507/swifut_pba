//
//  EditRecordView.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/02/16.
//

import SwiftUI
struct EditRecordView: View {
    @EnvironmentObject var appModel:AppModel
    @Binding var isOpen:Bool
    @Binding var selectedRecord:Record
    @StateObject var erModel: EditRecordModel
    init(isOpen:Binding<Bool>,selectedRecord:Binding<Record>) {
        self._isOpen = isOpen
        self._selectedRecord = selectedRecord
        self._erModel = StateObject(wrappedValue: EditRecordModel(selectedRecord:selectedRecord.wrappedValue))
    }
    
    var body: some View {
        ZStack{
            Color.black
                .edgesIgnoringSafeArea(.all)
                .opacity(0.2)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        selectedRecord = Record()
                    }
                }
            VStack{
                //タイトル
                HStack{
                    Image(selectedRecord.type ?? "")
                        .resizable()
                        .frame(width: 30, height: 40)
                    Spacer()
                    Text(selectedRecord.type ?? "")
                        .font(.largeTitle)
                    Spacer()
                    Image(selectedRecord.type ?? "")
                        .resizable()
                        .frame(width: 30, height: 40)
                }
                .padding()
                .foregroundColor(Color(UIColor.label))
                .background(Color(UIColor.systemBackground))
                //日付
                HStack{
                    Spacer()
                    Text("\(selectedRecord.date ?? "")")
                        .font(.title)
                    Spacer()
                }
                .padding()
                .foregroundColor(Color(UIColor.label))
                .background(Color(UIColor.systemBackground))
                HStack{
                    Spacer()
                    TextField("量を入力",value:$erModel.selectedRecord.amount, format:.number )
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
                        await erModel.updateRecord()
                        isOpen = false
                    },
                    enableStatus: erModel.isButtonEnabled
                )
                .padding()
                .background(Color(UIColor.systemBackground))
                //削除
                ButtonView(
                    text: "削除",
                    clickAction: {
                        await erModel.deleteRecord()
                        isOpen = false
                    },
                    enableStatus: true
                )
                .padding()
                .background(Color(UIColor.systemBackground))
                //キャンセル
                HStack{
                    
                    Button(action: {
                        selectedRecord = Record()
                        isOpen = false
                    }){
                        Spacer()
                        Text("キャンセル")
                            .font(.system(size: 22))
                        Spacer()
                    }
                }
                .padding()
                .foregroundColor(.red) // テキストのカラーを設定
                .background(Color(UIColor.systemBackground))
                
            }
            .padding()
        }
    }
}

#Preview {
    EditRecordView(
        isOpen: Binding.constant(true),
        selectedRecord: Binding.constant(Record(id: 100,date:"2024-02-12",type: "ビール",amount: 250)))
        .environmentObject(AppModel())
}

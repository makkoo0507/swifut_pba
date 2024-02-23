//
//  RankView.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/02/16.
//

import SwiftUI

struct RankView: View {
    @EnvironmentObject var appModel:AppModel
    @ObservedObject var rankModel = RankModel()
    init() {
        UISlider.appearance().setThumbImage(UIImage(), for: .normal)
    }
    var body: some View {
        VStack(spacing:0){
            HStack{
                Spacer()
                Text("経過")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .padding(.bottom)
                Spacer()
            }
            .foregroundColor(.primary)
            .background(Color.blue.opacity(0.9))
            VStack{
                List{
                    Section(header: Text("期間").font(.headline)) {
                        VStack{
                            HStack{
                                Text(appModel.selectedRoom.start ?? "1000-01-01")
                                Spacer()
                                Text("~")
                                Spacer()
                                Text(appModel.selectedRoom.end ?? "1000-01-01")
                            }
                            Slider(value: Binding.constant(getProgress(start: appModel.selectedRoom.start ?? "", end: appModel.selectedRoom.end ?? "")))
                            
                        }
                    }
                    Section(header: Text("順位").font(.headline)) {
                        ForEach(rankModel.rankList.sorted(by: { $0.rank ?? 0 < $1.rank ?? 0 }),id: \.user_id){ rank in
                            VStack{
                                HStack{
                                    Text("\(rank.rank ?? 0) 位")
                                    Text("\(rank.user_name ?? "") ")
                                    Spacer()
                                }
                                HStack{
                                    Text("合計飲酒量: \(rank.amount ?? 0)")
                                }
                            }
                        }
                    }
                }
            }
            .onAppear{
                Task{
                    await rankModel.setRanks(roomId: appModel.selectedRoom.id ?? 0)
                }
            }
            .onChange(of: appModel.selectedRoom.id) {
                Task{
                    await rankModel.setRanks(roomId: appModel.selectedRoom.id ?? 0)
                }
            }
        }
    }
}

#Preview {
    RankView()
        .environmentObject(AppModel())
}

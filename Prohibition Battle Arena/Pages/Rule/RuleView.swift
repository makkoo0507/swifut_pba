//
//  RuleView.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/01/06.
//

import SwiftUI

struct RuleView: View {
    @EnvironmentObject var appModel: AppModel
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Text("ルール")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .padding(.bottom)
                Spacer()
            }
            .foregroundColor(.primary)
            .background(Color.blue.opacity(0.9))
            VStack{
                HStack{
                    Image(systemName: "book")
                    Text("ルール")
                }
                .padding()
                Divider()
                VStack(alignment: .leading){
                    Text("・飲酒量の多い人の負け").padding()
                    Text("・期間：\(appModel.selectedRoom.start ?? "") ~ \(appModel.selectedRoom.end ?? "")").padding()
                    Text("・1杯(350ml)あたり\(appModel.selectedRoom.penalty ?? "")とする。").padding()
                    Text( "・最終結果: \(appModel.selectedRoom.punishment_game_performer ?? "")は、\(appModel.selectedRoom.punishment_game_target ?? "")に\(appModel.selectedRoom.punishment_game_action ?? "")")
                        .padding(.bottom, 30)
                        .padding(.top)
                        .padding(.horizontal)
                }
            }
            .overlay(RoundedRectangle(cornerRadius: 30)
                .stroke(Color.blue, lineWidth: 3))
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .padding()
            VStack{
                HStack{
                    Image(systemName: "person.3.sequence")
                    Text("参加者")
                }
                .padding()
                Divider()
                List(appModel.roomMembers, id: \.self.id){ member in
                    Text(member.name ?? "")
                }
                .listStyle(PlainListStyle())
            }
            .overlay(RoundedRectangle(cornerRadius: 30)
                .stroke(Color.blue, lineWidth: 3))
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .padding()
        }
    }
}
struct RuleView_preview: PreviewProvider {
    static var previews: some View {
        RuleView()
            .environmentObject(AppModel())
    }
}

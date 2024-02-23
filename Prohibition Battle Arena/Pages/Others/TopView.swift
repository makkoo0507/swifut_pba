//
//  TopView.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/01/06.
//

import SwiftUI

struct TopView: View {
    init(){
        let _: Date = Calendar.current.getDate(year: 2024, month: 11, day: 12)
    }
    var body: some View {
        VStack{
            Image(systemName: "figure.baseball")
                .font(.system(size: 150))
                .padding()
            Text("Topページ")
        }
//        .font(.system(size: 50))
        
    }
}

#Preview {
    TopView()
}

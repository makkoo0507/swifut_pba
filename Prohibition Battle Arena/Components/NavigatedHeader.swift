//
//  NavigatedHeader.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/02/07.
//

import SwiftUI

struct NavigatedHeader: View {
    var title: String
    var dismissAction: () -> Void // dismissアクションを受け取るクロージャー
    
    var body: some View {
        ZStack {
            HStack {
                Button(action: {
                    dismissAction() // dismissアクションを実行
                }) {
                    Image(systemName: "chevron.backward")
                        .font(.system(size: 25))
                }
                .padding(.leading, 20)
                Spacer()
            }
            Text(title)
                .padding()
                .fontWeight(.medium)
        }
        Divider()
    }
}

#Preview {
    NavigatedHeader(title: "distinated タイトル", dismissAction:{})
}

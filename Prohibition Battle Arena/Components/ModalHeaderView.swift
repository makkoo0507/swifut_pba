//
//  ModalHeaderView.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/02/07.
//

import SwiftUI

struct ModalHeaderView: View {
    @Binding var isOpen: Bool
    var title:String
    init(isOpen: Binding<Bool>, title: String) {
        self._isOpen = isOpen
        self.title = title
    }
    var body: some View {
        ZStack{
            HStack{
                Button(action: {
                    isOpen.toggle()
                }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 25))
                }
                .padding(.leading,20)
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
    ModalHeaderView(isOpen: Binding.constant(true),title: "モーダルタイトル")
}

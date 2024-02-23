//
//  HamburgerMenuView.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/02/13.
//

import SwiftUI

struct HamburgerMenuView: View {
    @Binding var isMenuOpen:Bool
    var body: some View {
        VStack{
            HStack{
                Button {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        isMenuOpen.toggle()
                    }
                } label: {
                    Image(systemName: "line.3.horizontal")
                        .font(.system(size: 25))
                        .foregroundColor(.primary)
                }
                .padding(.leading)
                Spacer()
            }
            Spacer()
        }
        .background(.clear)
    }
}

#Preview {
    HamburgerMenuView(isMenuOpen: Binding.constant(false))
}

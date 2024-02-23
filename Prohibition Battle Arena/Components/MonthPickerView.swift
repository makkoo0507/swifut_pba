//
//  ManthPickerView.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/02/11.
//

import SwiftUI

struct MonthPickerView: View {
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)
    @Binding var isOpen:Bool
    @Binding var year:Int
    @Binding var month:Int
    var body: some View {
        VStack {
            HStack{
                Spacer()
                Button(action: {
                    year -= 1
                }){
                    Image(systemName: "chevron.backward")
                }
                Spacer()
                Button(action: {
                    print(year)
                }){
                    Text(String(format: "%d", year))
                }
                Spacer()
                Button(action: {
                    year += 1
                }){
                    Image(systemName: "chevron.right")
                }
                Spacer()
            }
            .padding()
//            .font(.system(size: 16))
            .foregroundColor(.primary)
            .background(Color.gray.opacity(0.5))
            let data = (1...12).map { $0 }
            LazyVGrid(columns: columns) {
                ForEach(data, id: \.self) { item in
                    Button(action: {
                        month = item
                        isOpen = false
                    }){
                        Text("\(item)月")
                            .font(.system(size: 16))
                            .foregroundColor(.primary)
                            .padding(10)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
//            .background(Color.gray.opacity(0.3))
        }
    }
}

#Preview {
    MonthPickerView(isOpen: Binding.constant(true),year: Binding.constant(2024), month: Binding.constant(2))
}

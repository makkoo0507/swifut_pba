//
//  HeadMonthPickerView.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/02/11.
//

import SwiftUI

struct HeadMonthPickerView: View {
    @Binding var year:Int
    @Binding var month:Int
    @State var showMonthPicker: Bool = false
    @State var isShowPopover:Bool = true
    var body: some View {
        HStack{
            Spacer()
            Button(action: {
                month -= 1
                if(month == 0){
                    year -= 1
                    month = 12
                }
            }){
                Image(systemName: "chevron.backward")
            }
            Spacer()
            Button(action: {
                showMonthPicker = true
            }){
                Text("\(String(year))/\(String(month))")
            }
            Spacer()
            Button(action: {
                month += 1
                if(month == 13){
                    year += 1
                    month = 1
                }
            }){
                Image(systemName: "chevron.right")
            }
            Spacer()
        }
        .padding()
        .font(.system(size: 25))
        .foregroundColor(.primary)
        .background(Color.blue.opacity(0.9))
        .popover(isPresented: $showMonthPicker, attachmentAnchor: .point(.bottom ), arrowEdge: .bottom) {
            MonthPickerView(isOpen:$showMonthPicker, year: $year, month: $month)
                .frame(width: 320, height: 220)
                .presentationCompactAdaptation(.none)
        }
    }
}

#Preview {
    HeadMonthPickerView(year: Binding.constant(2024), month: Binding.constant(2))
}

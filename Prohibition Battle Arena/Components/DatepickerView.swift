//
//  DatepickerView.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/02/03.
//

import SwiftUI

struct DatepickerView: View {
    @Binding var isOpen: Bool
    @Binding var birthday: Date
    @State var originalBirthday: Date
    init(isOpen: Binding<Bool>, birthday: Binding<Date>) {
        _isOpen = isOpen
        _birthday = birthday
        _originalBirthday = State(initialValue: _birthday.wrappedValue)
    }
    var body: some View {
        VStack {
            HStack{
                Button(action: {
                    birthday = originalBirthday
                    isOpen.toggle()
                }){
                    Text("キャンセル")
                        .foregroundColor(Color(UIColor.systemRed))
                }
                .onAppear{
                    originalBirthday = $birthday.wrappedValue
                }
                Spacer()
                Button(action: {
                    originalBirthday = birthday
                    isOpen.toggle()
                }){
                    Text("完了")
                        .foregroundColor(.primary)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            DatePicker("", selection: $birthday, displayedComponents: .date)
                .datePickerStyle(WheelDatePickerStyle())
                .environment(\.locale, Locale(identifier: "ja_JP"))
                .padding(.horizontal)
        }
        .presentationDetents([.height(270)])
    }
}

#Preview {
    DatepickerView(isOpen: Binding.constant(true), birthday: Binding.constant(Date()))
}

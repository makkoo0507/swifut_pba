//
//  SummaryListingView.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/02/11.
//

import SwiftUI
struct SummaryListingView: View {
    var calendarDates:[CalendarStringDates]
    var summaryLists:[String:Int]
    var year:Int
    var month:Int
    init(year: Int, month: Int, lists: [String:Int]) {
        self.year = year
        self.month = month
        self.calendarDates = getCalendarDates(year:year,month:month)
        self.summaryLists = lists
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 1.5){
            ForEach(calendarDates) { calendarDate in
                if let date = calendarDate.date {
                    let day = Calendar.current.day(for: parseDate(date,format: "yyyy-MM-dd")!) ?? 0
                    if let value = summaryLists[date]{
                        if(value != 0){
                            HStack(spacing:3){
                                Text("\(day)")
                                    .frame(width: 21)
                                HStack(spacing:0){
                                    Image("傘")
                                        .resizable()
                                        .frame(width: 13, height: 13)
                                    Text(String(value))
                                        .font(.system(size: 14))
                                }
                            }
                        }else{
                            HStack(spacing:3){
                                Text("\(day)")
                                    .frame(width: 21)
                                HStack(spacing:0){
                                    Spacer()
                                    Image("太陽")
                                        .resizable()
                                        .frame(width: 13, height: 13)
                                    Spacer()
                                }
                            }
                        }
                    }else{
                        if(parseDate(date,format: "yyyy-MM-dd") ?? Date() < Date()){
                            HStack(spacing:3){
                                Text("\(day)")
                                    .frame(width: 21)
                                HStack(spacing:0){
                                    Spacer()
                                    Image("太陽")
                                        .resizable()
                                        .frame(width: 13, height: 13)
                                    Spacer()
                                }
                            }
                        }else{
                            HStack(spacing:3){
                                Text("\(day)")
                                    .frame(width: 21)
                                HStack(spacing:0){
                                    Spacer()
                                }
                            }
                        }
                    }
                    Divider()
                } else {
                    Text("")
                    Divider()
                }
            }
            Spacer()
        }
        .padding(.top,10)
        .frame(width: 80)
        .background(Color.blue.opacity(0.3))
    }
}
    

#Preview {
    SummaryListingView(year: 2024, month: 2,lists: [
        "2024-02-01":0,
        "2024-02-02":350,
        "2024-02-10":1350,
    ])
}

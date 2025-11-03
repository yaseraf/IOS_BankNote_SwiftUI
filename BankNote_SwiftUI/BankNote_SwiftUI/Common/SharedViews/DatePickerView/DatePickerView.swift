//
//  DatePickerView.swift
//  QSC
//
//  Created by FIT on 28/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import SwiftUI

struct DatePickerView: View {
    
    let title:String
    let dateRangeType: DateRangeType
    let changeDateRange: Bool
    @Binding var date:Date
    @State private var isCalendarPresented: Bool = true

    var onTap:((Date?)->Void)
    
    enum DateRangeType {
        case future
        case past
        case none
    }
    
    
    var dateClosedRange: ClosedRange<Date> {
        
        if title != "Execution" {
            let calendar = Calendar.current
            let today = changeDateRange ? Date() : Date.distantFuture
            
            // Create a date representing January 1, 1900
            if dateRangeType == .past {
                let startDate = calendar.date(from: DateComponents(year: 1900, month: 1, day: 1))!
                
                return startDate...today
            } else if dateRangeType == .future {
                let endDate = calendar.date(from: DateComponents(year: 3000, month: 1, day: 1))!
                
                return today...endDate

            } else if dateRangeType == .none{
                return Date.distantPast...Date.distantFuture
            }
        } else {
            let startDate =  Calendar.current.date(byAdding: .day, value: changeDateRange == true ? 1 : 0, to: Date())!
            return startDate...Date.distantFuture
        }
        
        return Date.distantPast...Date.distantFuture
//        else if dateRangeType == .future{
//            
//            let calendar = Calendar.current
//            var dayComponent = DateComponents()
//                dayComponent.day = 1
//            let startDate =  calendar.date(byAdding: dayComponent, to: Date())!
//
//            let today = changeDateRange ? Date() : Date.distantFuture
//                        
//            return startDate...Date.distantFuture
//        }
    }
    
    var body: some View {
        ZStack{
            if isCalendarPresented {
                Color.black.opacity(0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isCalendarPresented = false // Dismiss when tapped outside
                        onTap(date)
                    }
                
                VStack{
                    
                    
                    DatePicker(title, selection:$date, in: dateClosedRange, displayedComponents: .date)
//                        .onChange(of: $date.wrappedValue, perform: { value in
//                            $date.wrappedValue = value
//                            onTap(value)
//                        })
                        .datePickerStyle(.graphical)
//                        .pickerStyle(.)
                        .frame(maxHeight: 400)
                        .padding(.horizontal,8)
                        .padding(.horizontal,8)
                        .background(Color.colorBGPrimary)
                        .padding(8)
                        .cornerRadius(24)
                        .shadow(color: .black.opacity(0.1), radius: 5, x: 1, y: 1)
                    
                    Button(action: {
                        isCalendarPresented = false
                        onTap(date)
                    }) {
                        Text("Done")
                            .foregroundStyle(.white)
                            .padding()
                            .background(Color.colorPrimary)
                            .cornerRadius(8)
                    }
                    
                    
                }
            }
        }


    }
}

//#Preview {
//    DatePickerView(title: "", changeDateRange: false, onTap: {_ in })
//}

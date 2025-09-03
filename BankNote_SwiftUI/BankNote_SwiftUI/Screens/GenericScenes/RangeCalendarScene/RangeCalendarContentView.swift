//
//  RangeCalendarContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 14/08/2025.
//

import Foundation
import SwiftUI

struct RangeCalendarContentView: View {
    
    var title:Binding<String?>
    var selectedDateFrom:Binding<Date?>
    var selectedDateTo:Binding<Date?>
    var isMultiSelect:Binding<Bool?>
    
    var onDismiss:() -> Void
    var onConfirm:() -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            headerView
            
            if isMultiSelect.wrappedValue == true {
                selectionView
            }
            
            RangeCalendarView(startDate: selectedDateFrom, endDate: selectedDateTo, isMultiSelect: isMultiSelect)
                .padding(.horizontal, 18)
                .frame(maxHeight: 340)
            
            if isMultiSelect.wrappedValue == true {
                Spacer()
            }
            
            Divider()
            
            bottomButtonView
        }
    }
    
    private var headerView: some View {
        VStack(spacing: 0) {
            RoundedRectangle(cornerRadius: 100)
                .fill(Color.colorBorder)
                .frame(maxWidth: 46, maxHeight: 4)
                .padding(.top, 16)
                .padding(.bottom, 8)
            
            HStack {
                Circle()
                    .frame(width: 40, height: 40)
                    .opacity(0)
                
                Spacer()
                
                Text(title.wrappedValue ?? "")
                    .font(.apply(.medium, size: 16))
                
                Spacer()
                
                Circle()
                    .fill(Color.colorBG)
                    .frame(width: 40, height: 40)
                    .overlay {
                        Image("ic_close")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
                    .background(Circle().stroke(lineWidth: 1).fill(Color.colorBorder))
                    .onTapGesture {
                        onDismiss()
                    }
            }
            .padding(.horizontal, 24)
        }
    }
    
    private var selectionView: some View {
        HStack(spacing: 0) {
            Text("select_date".localized)
                .font(.apply(.medium, size: 16))
            Spacer()
            HStack(spacing: 8) {
                Image("ic_calendar")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(Color.colorTextPrimary)
                    .frame(width: 20, height: 20)
                
                Text("\(selectedDateFrom.wrappedValue?.toString(dateFormat: .ddMMyyyy) ?? "") - \(selectedDateTo.wrappedValue?.toString(dateFormat: .ddMMyyyy) ?? "")")
                    .font(.apply(.medium, size: 14))
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 16)
            .background(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 1).fill(Color.colorBorder))
        }
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity)
    }
    
    private var bottomButtonView: some View {
        Text("confirm".localized)
            .font(.apply(.medium, size: 16))
            .foregroundStyle(.white)
            .frame(minHeight: 48)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 16).fill(Color.colorPrimary))
            .padding(.horizontal, 24)
            .onTapGesture {
                onConfirm()
            }
    }

}

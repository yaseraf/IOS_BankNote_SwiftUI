//
//  RangeCalendarView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 14/08/2025.
//

import SwiftUI
import FSCalendar

struct RangeCalendarView: UIViewRepresentable {
    @Binding var startDate: Date?
    @Binding var endDate: Date?
    @Binding var isMultiSelect: Bool?
    
    var onConfirm: ((Date, Date) -> Void)?
    
    class Coordinator: NSObject, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
        var parent: RangeCalendarView
        
        init(parent: RangeCalendarView) {
            self.parent = parent
        }
        
        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            if parent.isMultiSelect == true {
                // Multi-range selection
                if parent.startDate == nil || (parent.startDate != nil && parent.endDate != nil) {
                    parent.startDate = date
                    parent.endDate = nil
                } else if let start = parent.startDate {
                    if date < start {
                        parent.endDate = start
                        parent.startDate = date
                    } else {
                        parent.endDate = date
                    }
                }
            } else {
                // Single selection
                parent.startDate = date
                parent.endDate = nil
            }
            
            calendar.reloadData()
        }

        
        func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
            guard parent.isMultiSelect == true else { return nil } // no range highlight in single mode
            guard let start = parent.startDate, let end = parent.endDate else { return nil }
            if date >= start && date <= end {
                return UIColor.systemBlue.withAlphaComponent(0.15)
            }
            return nil
        }

        func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
            guard let start = parent.startDate else { return nil }
            if parent.isMultiSelect == true {
                if let end = parent.endDate {
                    if date == start || date == end {
                        return UIColor.systemBlue
                    }
                } else if date == start {
                    return UIColor.systemBlue
                }
            } else {
                // Single select → just highlight the picked day
                if date == start {
                    return UIColor.systemBlue
                }
            }
            return nil
        }

        
        func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
            return UIColor.label
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> FSCalendar {
        let calendar = FSCalendar()
        calendar.delegate = context.coordinator
        calendar.dataSource = context.coordinator
        
        // Styling
        calendar.scrollDirection = .horizontal
        calendar.scope = .month
        calendar.appearance.headerTitleFont = UIFont.systemFont(ofSize: 18, weight: .semibold)
        calendar.appearance.weekdayFont = UIFont.systemFont(ofSize: 14, weight: .medium)
        calendar.appearance.weekdayTextColor = UIColor.secondaryLabel
        calendar.appearance.headerTitleColor = UIColor.label
        calendar.appearance.selectionColor = UIColor.systemBlue
        calendar.appearance.todayColor = .clear
        calendar.appearance.todaySelectionColor = UIColor.systemBlue
        
        // RTL Support for Arabic
        if AppUtility.shared.isRTL {
            calendar.semanticContentAttribute = .forceRightToLeft
        }
        
        return calendar
    }
    
    func updateUIView(_ uiView: FSCalendar, context: Context) {
        uiView.reloadData()
    }
}

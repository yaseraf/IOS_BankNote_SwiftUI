//
//  HorizontalIndicatorView.swift
//  QSC
//
//  Created by FIT on 07/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import SwiftUI

struct HorizontalIndicatorView: View {
    enum SelectIndexType:Int{
        case one = 0
        case two = 1
        case three = 2 
        case four = 3
        case five = 4
        case six = 5
    }
    private let maxCount = 6
    var selectIndex:Binding<SelectIndexType>



    var body: some View {
        HStack(alignment: .top,spacing:8){

                    ForEach(0..<maxCount,id: \.self){ index in

                        let select = index <= selectIndex.wrappedValue.rawValue
                        rowView(select: select, width: (UIScreen.main.bounds.width - 32) / CGFloat(maxCount) - (7 ))
                    }

        }
        
    }

    private func rowView(select:Bool,width:CGFloat) ->some View{

       return RoundedRectangle(cornerRadius: 99)
            .fill(select ? Color.colorPrimary: Color.colorQuaternary)
            .frame(height:7)
            .frame(width: width)

    }
}

#Preview {
    HorizontalIndicatorView(selectIndex: .constant(.two))
}

//
//  ListViewItems.swift
//  QSC
//
//  Created by FIT on 27/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import SwiftUI

struct ListViewItems: View {
    var selectItem:Binding<ItemPickerModelType?>
    var list:Binding<[ItemPickerModelType]>
    var onItemTap:((ItemPickerModelType)->Void)
    var body: some View {

        VStack{
            LazyVStack{
                ForEach(Array(list.wrappedValue.enumerated()), id: \.offset) { index, element in
                    Button {
                        onItemTap(element)

                    } label: {
                        cellItem(item: element, select: selectItem.wrappedValue?.id == element.id)
                    }
                    .listRowInsets(.init(top: 0, leading: 10, bottom: 0, trailing: 10))

                }

            }
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.colorBGPrimary)

            )
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.colorBorderPrimary,lineWidth: 1)
                    .shadow(color:Color.black.opacity(0.3),radius: 4,x:1, y:1)
            )
            Spacer()
        }


//

    }

    func cellItem(item:ItemPickerModelType, select:Bool) -> some View{
        return  HStack{
            VStack(alignment: .leading,spacing:4){
                Text(item.name)
                    .font(.apply(size:15))
                    .foregroundStyle(Color.colorTextPrimary)
                
                if !item.subName.isEmpty{
                    Text(item.subName)
                        .font(.apply(size:12))
                        .foregroundStyle(Color.colorTextTernary.opacity(0.4))
                }
            }
            if select{
                Spacer()
                Image("ic_checkMark").resizable()
                    .renderingMode(.template)
                    .frame(width: 20)
                    .frame(height:  20)
                    .foregroundStyle(Color.colorPrimary)
            }

        }.frame(maxWidth: .infinity,alignment: .leading)
        .padding(10)
    }
}

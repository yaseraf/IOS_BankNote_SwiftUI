//
//  TagFillterView.swift
//  QSC
//
//  Created by Hijjawi97 on 15/09/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import SwiftUI

struct TagFillterView: View {
    let tag: OrderItemFilterUIModel
    @Binding var isSelected: Bool

    var body: some View {
        HStack {
            Text(tag.name)
                .foregroundColor(.colorTextPrimary)
            if isSelected {
                Image(systemName: "xmark")
                    .foregroundColor(.colorTextPrimary)

            }
        }
        .padding(.all, 10)
        .background(isSelected ? Color.colorBrand : Color.colorQuaternary)
        .foregroundColor(.white)
        .cornerRadius(99)
    }
}

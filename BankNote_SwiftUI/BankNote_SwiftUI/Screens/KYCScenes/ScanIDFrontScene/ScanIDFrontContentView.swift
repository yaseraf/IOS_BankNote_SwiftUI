//
//  ScanIDFrontContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 15/09/2025.
//

import Foundation
import SwiftUI

struct ScanIDFrontContentView: View {
    
    var onRetakeTap: () -> Void
    var onNextTap: () -> Void
    
    var body: some View {
        VStack {
            titleView
            
            Spacer()
            
            contentView
            
            Spacer()
            
            bottomView
        }
        .background(.black)
    }
    
    private var titleView: some View {
        Text("scan_the_front_of_your_national_id".localized)
            .font(.cairoFont(.semiBold, size: 18))
            .foregroundStyle(.white)
    }
    
    private var contentView: some View {
        VStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(.white)
                .frame(maxWidth: 357, maxHeight: 216)
        }
    }
    
    private var bottomView: some View {
        HStack {
            Button {
                onRetakeTap()
            } label: {
                Text("retake".localized)
                    .font(.cairoFont(.semiBold, size: 14))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(RoundedRectangle(cornerRadius: 99).fill(Color(hex: "#828282")))
            }
            
            Button {
                onNextTap()
            } label: {
                Text("next".localized)
                    .font(.cairoFont(.semiBold, size: 14))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(RoundedRectangle(cornerRadius: 99).fill(Color(hex: "#9C4EF7")))
            }


        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 18)
    }
}

#Preview {
    ScanIDFrontContentView(onRetakeTap: {
        
    }, onNextTap: {
        
    })
}

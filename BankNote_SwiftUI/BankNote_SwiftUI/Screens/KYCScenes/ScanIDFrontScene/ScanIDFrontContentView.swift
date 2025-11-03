//
//  ScanIDFrontContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 15/09/2025.
//

import Foundation
import SwiftUI

struct ScanIDFrontContentView: View {
    @StateObject private var cameraCoordinator = CameraCoordinator()
    @State var hasCaptured: Bool = false

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
//            CameraView(coordinator: cameraCoordinator)
//                .clipShape(RoundedRectangle(cornerRadius: 12))
//                .frame(maxWidth: 357, maxHeight: 216)
        }
    }
    
    private var bottomView: some View {
        HStack {
            if hasCaptured {
                Button {
//                    onRetakeTap()
                    hasCaptured = false
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
            } else {
                Button {
                    
                    cameraCoordinator.takePhoto()
                    hasCaptured = true
     
                } label: {
                    Label {
                        Text("Take Photo")
                    } icon: {
                        ZStack {
                            Circle()
                                .strokeBorder(.white, lineWidth: 3)
                                .frame(width: 62, height: 62)
                            Circle()
                                .fill(.white)
                                .frame(width: 50, height: 50)
                        }
                    }
                }
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

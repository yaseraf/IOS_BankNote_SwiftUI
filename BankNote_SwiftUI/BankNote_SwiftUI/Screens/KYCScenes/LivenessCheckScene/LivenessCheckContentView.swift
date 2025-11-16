//
//  LivenessCheckContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 15/09/2025.
//

import Foundation
import SwiftUI

struct LivenessCheckContentView: View {
    
    @State var stepNumber:Int = 5
    @StateObject private var SdkIntegration = sdkIntegration()

    var onContinueTap:()->Void
    
    var body: some View {
        VStack {
            logoView
            
            SegmentsView(stepNumber: stepNumber)
            
            contentView
            
            pointsView
                        
            Spacer()
            
            bottomView
        }
    }
    
    private var logoView: some View {
        VStack(spacing: 0) {
            Image("ic_logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 225, maxHeight: 225)
            
            Text("XNTRQ".localized)
                .textCase(.uppercase)
                .font(.cairoFont(.extraBold, size: 40))
        }
    }
    
    private var contentView: some View {
        VStack(spacing: 0) {
            Text("liveness_check".localized)
                .font(.cairoFont(.semiBold, size: 18))
            
            Text("well_use_this_information_to_verify_your_identity".localized)
                .font(.cairoFont(.light, size: 12))
            
        }
    }
    
    private var pointsView: some View {
        VStack(spacing: 10) {
            HStack {
                Image("ic_questionMark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                
                Text("make_sure_there_is_good_lighting".localized)
                    .font(.cairoFont(.light, size: 12))

                Spacer()
            }
            
            HStack {
                Image("ic_questionMark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                
                Text("take_off_your_glasses_if_your_wearing_one".localized)
                    .font(.cairoFont(.light, size: 12))

                Spacer()
            }

            
            HStack {
                Image("ic_questionMark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                
                Text("look_directly_into_the_camera".localized)
                    .font(.cairoFont(.light, size: 12))

                Spacer()
            }

        }
        .padding(.horizontal, 18)
    }
    
    
    private var bottomView: some View {
        return VStack {
            Button {
//                SdkIntegration.startLiveness(transactionFrontId: "123456")
                onContinueTap()
            } label: {
                Text("liveness_check".localized)
                    .font(.cairoFont(.semiBold, size: 18))
                    .foregroundStyle(.white)
                    .frame(minWidth: 357, minHeight: 51)
                    .background(RoundedRectangle(cornerRadius: 99).fill(Color.colorPrimary))
            }
            
            Spacer().frame(height: 24)
        }
    }

}

#Preview {
    LivenessCheckContentView(onContinueTap: {})
}

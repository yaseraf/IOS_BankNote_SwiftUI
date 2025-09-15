//
//  LivenessCheckContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 15/09/2025.
//

import Foundation
import SwiftUI

struct LivenessCheckContentView: View {
    
    @State var stepNumber:Int = 3
    
    var onContinueTap:()->Void
    
    var body: some View {
        VStack {
            logoView
            
            segmentsView
            
            contentView
                        
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
            
            Text("bank_note".localized)
                .textCase(.uppercase)
                .font(.cairoFont(.extraBold, size: 40))
        }
    }
    
    private var segmentsView: some View {
        HStack(spacing: 4) {
            ForEach(0...6, id: \.self) { index in
                if stepNumber > index {
                    LinearGradient( gradient: Gradient(colors: [Color(hex: "#FC814B"), Color(hex: "#9C4EF7"), Color(hex: "#629AF9")]), startPoint: .leading, endPoint: .trailing)
                    
                        .cornerRadius(12)
                } else {
                    RoundedRectangle(cornerRadius: 12).fill(Color(hex: "#DDDDDD"))
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 6)
        .padding(.horizontal, 18)
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
        VStack {
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
    }
    
    
    private var bottomView: some View {
        return VStack {
            Button {
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

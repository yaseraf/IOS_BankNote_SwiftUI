//
//  LoadingView.swift
//  QSC
//
//  Created by FIT on 29/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        GeometryReader{geo in
            ZStack{
                Color.black.opacity(0.2).ignoresSafeArea()
                HStack(alignment:.center){
                    VStack(alignment: .center,spacing: 16){
                        Text("loading".localized)
                            .font(.apply(size: 14))
                            .foregroundColor(.colorPrimary)
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .colorPrimary))
                            .scaleEffect(2.0, anchor: .center)
                    }
                    .frame(width: geo.size.width / 2 )
                    .padding(.vertical,20)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.colorPrimary,lineWidth: 1)
                            .background(RoundedRectangle(cornerRadius: 20)
                                .fill(Color.colorBGPrimary))

                    )

                }.frame(maxWidth: .infinity)
            }


        }
    }

}

#Preview {
    LoadingView()
}

//
//  CountryPickerContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 07/09/2025.
//

import Foundation
import SwiftUI

struct CountryPickerContentView: View {
    @State private var selected = countries.first!

        var body: some View {
            VStack {

                Spacer()
                
                GrabberView()
                
                Picker("Select Country", selection: $selected) {
                    ForEach(countries) { country in
                        HStack {
                            Text(country.flag)
                            Text("\(country.localizedName) \(country.code)")
                        }
                        .tag(country)
                    }
                }
                .pickerStyle(.wheel)

//                Text("Selected: \(selected.flag) \(selected.localizedName) \(selected.code)")
//                    .padding()
            }
            .padding(.bottom,AppUtility.bottomNotch)
            .padding(.horizontal,16)
            .padding(.top,16)
            .background(Color.clear)
            .cornerRadius(24, corners: [.topLeft,.topRight])
        }
}

#Preview {
    CountryPickerContentView()
}

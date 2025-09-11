//
//  HelpContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 11/09/2025.
//

import Foundation
import SwiftUI

struct HelpContentView: View {
    
    struct FAQ: Identifiable {
        let id = UUID()
        let question: String
        let answer: String
    }
    
    // An array of FAQ items to display.
    let faqs: [FAQ] = [
        FAQ(question: "How To Top-Up My Balance", answer: "Go to the Home Page. Click on the Top-Up Button..."),
        FAQ(question: "How To Top-Up My Balance", answer: "Go to the Home Page. Click on the Top-Up Button..."),
        FAQ(question: "How To Top-Up My Balance", answer: "Go to the Home Page. Click on the Top-Up Button..."),
        FAQ(question: "How To Top-Up My Balance", answer: "Go to the Home Page. Click on the Top-Up Button..."),
        FAQ(question: "How To Top-Up My Balance", answer: "Go to the Home Page. Click on the Top-Up Button...")
    ]
    
    var onBackTap:()->Void
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                // Header with a back button and title.
                HStack {
                    Button {
                        onBackTap()
                    } label: {
                        Image("ic_leftArrow")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                    }

                    Spacer()
                    
                    Text("Help")
                        .font(.cairoFont(.bold, size: 32))

                    Spacer()
                    
                    Image("ic_leftArrow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .opacity(0)
                }
                .padding()
                
                // Section title for FAQs.
                Text("Frequently Asked Questions")
                    .font(.cairoFont(.semiBold, size: 18))

                    .padding(.horizontal)
//                    .padding(.top)
                
                // Scrollable view for the list of FAQ items.
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(faqs.indices, id: \.self) {index in
                            FAQRow(faq: faqs[index])
                            if index < faqs.count - 1 {
                                Divider()
                            }
                        }
                    }
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(8)
                    .padding()
                }
                
                Spacer()
                
                // Chat button at the bottom.
                Button(action: {
                    // Action to handle chat initiation.
                    print("Chat with us button tapped!")
                }) {
                    HStack {
                        Image(systemName: "message.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                        Text("Chat With Us")
                            .font(.cairoFont(.semiBold, size: 14))

                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 99).fill(Color(hex: "#9C4EF7")))
                }
                .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                .padding()
            }
        }
    }
    
    
}

// A view for a single row in the FAQ list.
struct FAQRow: View {
    let faq: HelpContentView.FAQ
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(faq.question)
                .font(.cairoFont(.semiBold, size: 14))
            
            Text(faq.answer)
                .font(.cairoFont(.light, size: 14))

        }
        .padding(.horizontal, 25.5)
        .padding(.vertical)
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay(
            // A subtle divider at the bottom of each row.
            VStack {
                Spacer()
                Divider()
            }
            .padding(.leading)
        )
    }
}

#Preview {
    HelpContentView(onBackTap: {
        
    })
}

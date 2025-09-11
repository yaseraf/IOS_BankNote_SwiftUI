//
//  BadgesContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 11/09/2025.
//

import Foundation
import SwiftUI

struct BadgesContentView: View {
    
    // A sample data model for a single badge.
    struct Badge: Identifiable {
        let id = UUID()
        let name: String
        let progress: Double
        let total: Int
        let icon: String
        let tasks: [Task]
    }
    
    // A sample data model for a task within a badge.
    struct Task: Identifiable {
        let id = UUID()
        let description: String
        let isCompleted: Bool
    }
    
    // An array of all the badges to display.
    @State private var badges: [Badge] = [
        Badge(name: "Pioneer", progress: 5, total: 5, icon: "ic_pioneerBadge", tasks: [
            Task(description: "Completed your investor profile", isCompleted: true),
            Task(description: "Explored 3 different investment categories", isCompleted: true),
            Task(description: "Saved your first asset to watchlist", isCompleted: true),
            Task(description: "Completed your first learning module", isCompleted: true),
            Task(description: "Logged in 5 days in a row", isCompleted: true)
        ]),
        Badge(name: "Achiever", progress: 5, total: 5, icon: "ic_achieverBadge", tasks: [
            Task(description: "Invested in 5 different assets", isCompleted: true),
            Task(description: "Reached your first investment goal", isCompleted: true),
            Task(description: "Referred a friend to the app", isCompleted: true),
            Task(description: "Invested over $1,000", isCompleted: true),
            Task(description: "Completed 10 learning modules", isCompleted: true)
        ]),
        Badge(name: "Streak", progress: 1, total: 5, icon: "ic_streakBadge", tasks: [
            Task(description: "Logged in 3 days in a row", isCompleted: true),
            Task(description: "Logged in 5 days in a row", isCompleted: false),
            Task(description: "Logged in 7 days in a row", isCompleted: false),
            Task(description: "Logged in 10 days in a row", isCompleted: false),
            Task(description: "Logged in 15 days in a row", isCompleted: false)
        ]),
        Badge(name: "Loyalty", progress: 0, total: 5, icon: "ic_loyaltyBadge", tasks: [
            Task(description: "Used the app for 1 month", isCompleted: false),
            Task(description: "Used the app for 3 months", isCompleted: false),
            Task(description: "Used the app for 6 months", isCompleted: false),
            Task(description: "Used the app for 1 year", isCompleted: false),
            Task(description: "Used the app for 2 years", isCompleted: false)
        ]),
        Badge(name: "Bold", progress: 0, total: 5, icon: "ic_boldBadge", tasks: [
            Task(description: "Made a high-risk investment", isCompleted: false),
            Task(description: "Tried a new investment category", isCompleted: false),
            Task(description: "Made an investment over $500", isCompleted: false),
            Task(description: "Completed a challenge", isCompleted: false),
            Task(description: "Invested in a new market", isCompleted: false)
        ])
    ]
    
    // A state variable to keep track of which badge is currently expanded.
    // Only one badge can be expanded at a time.
    @State private var expandedBadgeName: String? = "Pioneer"
    
    var onBackTap:() -> Void
    
    var body: some View {
        ZStack {
            // Background gradient.
            LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.2), Color.white.opacity(0.5)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
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
                    
                    Text("Badges")
                        .font(.cairoFont(.bold, size: 32))

                    Spacer()
                    
                    Image("ic_leftArrow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .opacity(0)
                }
                .padding()
                
                // Scrollable view for the list of badges.
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(badges) { badge in
                            BadgeCard(badge: badge, isExpanded: expandedBadgeName == badge.name) {
                                withAnimation(.spring()) {
                                    // Toggle the expanded state.
                                    expandedBadgeName = (expandedBadgeName == badge.name) ? nil : badge.name
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

// A view for a single expandable badge card.
struct BadgeCard: View {
    let badge: BadgesContentView.Badge
    let isExpanded: Bool
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 15) {
            // Header for the badge card.
            HStack(spacing: 15) {
                // Badge icon.
                ZStack {
                    Image(badge.icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45, height: 45)
                        
                }
                .padding(.leading, 10)
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text(badge.name)
                            .font(.cairoFont(.semiBold, size: 18))
                        
                        Spacer()
                        
                        Text("\(Int(badge.progress))/\(badge.total)")
                            .font(.cairoFont(.semiBold, size: 14))

                    }

                    // Progress bar.
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.gray.opacity(0.3))
                                .frame(height: 10)
                            
                            // A gradient for the progress bar.
                            RoundedRectangle(cornerRadius: 5)
                                .fill(LinearGradient(gradient: Gradient(colors: [Color(hex: "#FC814B"), Color(hex: "#9C4EF7"), Color(hex: "#629AF9")]), startPoint: .leading, endPoint: .trailing))
                                .frame(width: geometry.size.width * CGFloat(badge.progress / Double(badge.total)), height: 10)
                        }
                    }
                    .frame(height: 10)
                }
                Spacer()
            }
//            .padding(.horizontal, 10)
            
            // Expandable content view.
            if isExpanded {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(badge.tasks) { task in
                        HStack(spacing: 10) {
                            Text(task.description)
                                .font(.cairoFont(.semiBold, size: 12))
                                .foregroundColor(task.isCompleted ? .primary : .secondary)
                            Spacer()
                            if task.isCompleted {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(Color(hex: "#629AF9"))
                            } else {
                                Image(systemName: "circle")
                                    .foregroundColor(.gray)
                            }
                            
                        }
                        Divider()
                    }
                }
                .padding(.leading, 85)
                .padding(.trailing, 18)
                .padding(.bottom, 20)
                .transition(.opacity.combined(with: .slide))
            }
        }
        .padding(.vertical, 15)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.8))
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
        )
        .onTapGesture(perform: action)
//        .padding(.horizontal)
    }
}

#Preview {
    BadgesContentView(onBackTap: {
        
    })
}

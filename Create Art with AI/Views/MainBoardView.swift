//
//  MainBoardView.swift
//  AI-generator
//
//  Created by Руслан Каприор on 14.09.2024.
//

import Foundation
import SwiftUI


struct MainBoardView: View {
    @State var favoritsVM = FavoritesViewModel()
    @State private var activeTab: Int = 0
    
    init() {
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().backgroundColor = .background
    }
    
    var body: some View {
        
        TabView(selection: $activeTab) {
            CreativityTabView(favoritesVM: $favoritsVM).tabItem {
                if #available(iOS 17.0, *) {
                    Label("Creativity", systemImage: "swirl.circle.righthalf.filled")
                } else {
                    Label {
                        Text("Creativity")
                    } icon: {
                        Image("swirl.circle.righthalf.filled")
                            .renderingMode(.template)
                    }
                }
            }.tag(0)
            
            InspirationTabView(favoritesVM: $favoritsVM).tabItem {
                Label("Inspiration", systemImage: "bolt.fill")
            }.tag(1)
            
            FavoritesTabView(images: $favoritsVM.images, favoritesVM: $favoritsVM, currentActiveTab: $activeTab).tabItem {
                Label("Favorites", systemImage: "star.circle.fill")
            }.tag(2)
            
        }
        .onChange(of: activeTab) { index in
            activeTab = index
        }
        .tabViewStyle(DefaultTabViewStyle())
        .foregroundColor(.white)
        .onAppear() {
        
            Task {
                await favoritsVM.getList()
            }
        
        }
    }
}

#Preview {
    MainBoardView()
}

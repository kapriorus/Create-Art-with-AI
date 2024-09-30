//
//  Onboarding.swift
//  AI-generator
//
//  Created by Руслан Каприор on 13.09.2024.
//

import Foundation
import SwiftUI
import StoreKit
import AppTrackingTransparency


struct OnboardingView: View {
    var openMainBoard: () -> Void
    
    private let persistenceController = PersistenceController.shared
    private let center = UNUserNotificationCenter.current()
    
    @State private var data: [OnboardingData] = OnboardingData.getDefaultMockData()
    @State private var showingAlert = false
    @State private var activeTab: Int = 0
    
    
    
    init(openMainBoard: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if #available(iOS 14, *) {
                ATTrackingManager.requestTrackingAuthorization { (status) in
                    print("IDFA STATUS: \(status.rawValue)")
                    
                }
            }
        }
        self.openMainBoard = openMainBoard
    }
    
    
    
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom), content: {
            Color.background.ignoresSafeArea().zIndex(-999)
            
            Rectangle().foregroundColor(Color.backgroundGray).ignoresSafeArea()
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 130, alignment: .center).zIndex(-1)
            
            TabView(selection: $activeTab) {
                ForEach(data, id: \.self) { item  in
                    OnboardingCard(item: item).gesture(DragGesture()).tag(item.id)
                }
            }
            .onChange(of: activeTab) { index in
                activeTab = index
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .animation(.easeInOut)
            .transition(.slide)
            
            
            
            
            BottomSheet(buttonText: activeTab == 3 ? "Turn on notifications" : "Continue", isBackgroundVisible: false) {
                if activeTab == 2 {
                    let scenes = UIApplication.shared.connectedScenes
                    if let windowScene = scenes.first as? UIWindowScene {
                        SKStoreReviewController.requestReview(in: windowScene)
                    }
                }
                if activeTab == 3 {
                    registerForNotification()
                    openMainBoard()
                } else {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        activeTab += 1
                    }
                }
            } bottomContent: {
                
                Button {
                    openMainBoard()
                } label: {
                    Text("Skip")
                        .foregroundColor(Color.textGray)
                }
                .padding()
                .offset(y: -10)
                .background(Color.backgroundGray)
                .transition(.move(edge: .bottom))
                .opacity(activeTab == 3 ? 1 : 0)
            
            }

        })
        .preferredColorScheme(.dark)
    }
}
    
    
    
struct OnboardingCard: View {
    private var item: OnboardingData
    
    private let device: String = UIDevice.current.name
    private var imageOffset: CGFloat = 0
    
    init(item: OnboardingData) {
        self.item = item
        
        let oldDevices: [String] = ["iPhone 6", "iPhone 6s", "iPhone 8", "iPhone SE (2rd generation)", "iPhone SE (3rd generation)"]
        
        if oldDevices.contains(where: {$0 == device}) {
            imageOffset = -45.0
        }
    }
    
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .center), content: {
            
            item.background
                .resizable()
                .aspectRatio(contentMode: .fit)
                .offset(x: 0.0, y: imageOffset)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            
            VStack(alignment: .center, content: {
                Text(item.title).applyCardStyle(isTitle: true)
                Text(item.description).applyCardStyle()
            })
            .foregroundColor(.white)
            .offset(x: 0, y: 150 + imageOffset)
        })
        
    }
}



#Preview {
    OnboardingView {
        
    }
}

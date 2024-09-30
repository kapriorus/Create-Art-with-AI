//
//  FavoritesTabView.swift
//  AI-generator
//
//  Created by Руслан Каприор on 17.09.2024.
//

import SwiftUI

struct FavoritesTabView: View {
    @Binding var images: [FetchDataResult]
    @Binding var favoritesVM: FavoritesViewModel
    @Binding var currentActiveTab: Int
    
    @State private var isPaywallModalShown: Bool = false
    
    @AppStorage("pro-unlocked") var isUnlocked: Bool = false
    
    var body: some View {
        
        NavigationView {
            
            ZStack(alignment: .topLeading) {
                Color.background.ignoresSafeArea()
                
                if images.isEmpty {
                    RoundedRectangle(cornerRadius: 20)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.textGray, Color.background]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .clipShape(
                            RoundedRectangle(cornerRadius: 20)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(style: StrokeStyle(lineWidth: 2, dash: [10, 5]))
                        )
                        .padding()
                        .opacity(0.06)
                    
                    VStack(alignment: .center) {
                        Image("photo.stack")
                            .padding(.top, 30)
                        
                        Text("Your collection is empty")
                            .font(.title2.bold())
                        Text("Create your first image and tap the heart on the one you like")
                            .font(.caption)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 50)
                            .padding(.top, 1)
                            .padding(.bottom, 15)
                        
                    
                        BlueButton(text: "Create", fullWidth: false) {
                            currentActiveTab = 0
                        }
                    
                    }.frame(maxWidth: .infinity)
                    
                    
                }
                
                
                
                ScrollView {
                    if !images.isEmpty {
                        VStack(alignment: .leading, spacing: 15) {

                            ImagesView(images: $images, favoritesVM: $favoritesVM)
                            
                        }.padding(15)
                    }
                }.navigationBarTitle("Favorites")
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        if !isUnlocked {
                            BlueButton(text: "PRO", icon: "crown", isSmall: true) {
                                self.isPaywallModalShown.toggle()
                            }
                            .fullScreenCover(isPresented: self.$isPaywallModalShown) {
                                PaywallView(isPresented: self.$isPaywallModalShown)
                            }
                            .scaleEffect(0.8)
                        }
                        
                        NavigationLink {
                            MenuView()
                        } label: {
                            Image(systemName: "line.3.horizontal")
                                .renderingMode(.template)
                                .foregroundColor(.textSelected)
                        }

                        
                    }
                }
            }
            .foregroundColor(.white)
        }
        
    }
}

fileprivate struct FavoritesTabViewPreview: View {
    @State var images: [FetchDataResult] = []
    @State var favoritesVM: FavoritesViewModel = .init()
    @State var currentActiveTab: Int = 2
    
    var body: some View {
        FavoritesTabView(images: $images, favoritesVM: $favoritesVM, currentActiveTab: $currentActiveTab).frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    FavoritesTabViewPreview()
}

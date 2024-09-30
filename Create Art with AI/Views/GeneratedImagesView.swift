//
//  GeneratedImagesView.swift
//  AI-generator
//
//  Created by Руслан Каприор on 25.09.2024.
//

import SwiftUI

struct GeneratedImagesView: View {
    var prompt: String
    @Binding var images: [FetchDataResult]
    @Binding var isPresented: Bool
    @Binding var favoritesVM: FavoritesViewModel
    @State var onRecreateClick: () -> Void
    
    @State private var isPaywallModalShown: Bool = false
    
    @AppStorage("pro-unlocked") var isUnlocked: Bool = false
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                ScrollView(.vertical) {
                    VStack(alignment: .leading) {
                        ImagesView(prompt: prompt, images: $images, favoritesVM: $favoritesVM)
                    }
                }.padding()
                
                
                BottomSheet(buttonText: "Recreate", icon: "arrow.triangle.2.circlepath") {
                    
                } bottomContent: {
                    
                }
            }
            .navigationTitle("Select Result")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        isPresented.toggle()
                    }.foregroundColor(.textSelected)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    if !isUnlocked {
                        BlueButton(text: "PRO", icon: "crown", isSmall: true) {
                            isPaywallModalShown = true
                        }
                        .fullScreenCover(isPresented: $isPaywallModalShown) {
                            PaywallView(isPresented: $isPaywallModalShown)
                        }
                    }
                }
            }
            
        }
    }
}


fileprivate struct GeneratedImagesViewPreview: View {
    @State var images: [FetchDataResult] = [
        FetchDataResult(id: "0", url: "https://cdn.apiframe.pro/images/31163383913893365614255687448879-1.png"),
        FetchDataResult(id: "1", url: "https://cdn.apiframe.pro/images/31163383913893365614255687448879-2.png"),
        FetchDataResult(id: "2", url: "https://cdn.apiframe.pro/images/31163383913893365614255687448879-3.png"),
        FetchDataResult(id: "3", url: "https://cdn.apiframe.pro/images/31163383913893365614255687448879-4.png")
    ]
    @State var isPresented: Bool = true
    @State var favoritesVM: FavoritesViewModel = .init()
    var prompt: String = "Generated Images"
    
    var body: some View {
        GeneratedImagesView(
            prompt: prompt,
            images: $images,
            isPresented: $isPresented,
            favoritesVM: $favoritesVM
        ) {
                
            }
    }
}

#Preview {
    ZStack {
        Color.background.ignoresSafeArea()
        GeneratedImagesViewPreview()
            .foregroundColor(.white)
            .preferredColorScheme(.dark)
    }
}


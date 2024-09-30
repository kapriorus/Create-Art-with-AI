//
//  InspirationTabView.swift
//  AI-generator
//
//  Created by Руслан Каприор on 17.09.2024.
//

import SwiftUI

struct InspirationTabView: View {
    @Binding var favoritesVM: FavoritesViewModel
    
    @State private var images: [FetchDataResult] = CONSTANTS.MOCKED_IMAGES

    @AppStorage("pro-unlocked") var isUnlocked: Bool = false
    @State private var isPaywallModalShown: Bool = false
    
    var body: some View {
        
        NavigationView {
            
            ZStack(alignment: .topLeading) {
                Color.background.ignoresSafeArea()
                
                Image("createBgImg").ignoresSafeArea()
                
                
                    ScrollView {
                        
                        
                        VStack(alignment: .leading, spacing: 15) {
                            
                            Text("Find AI generated images")
                                .font(.system(size: 17, weight: .bold))
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.vertical, 30)
                            ImagesView(images: $images, favoritesVM: $favoritesVM)
                            
                        }.padding(20)
                        
                    }
                    .navigationBarTitle("Inspiration")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            HStack {
                                if !isUnlocked {
                                    BlueButton(text: "PRO", icon: "crown", isSmall: true) {
                                        isPaywallModalShown.toggle()
                                    }
                                    .scaleEffect(0.8)
                                    .fullScreenCover(isPresented: $isPaywallModalShown) {
                                        PaywallView(isPresented: $isPaywallModalShown)
                                    }
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
                    
                
                
                
            }
        }
        
    }
}

fileprivate struct InspirationTabViewPreview: View {
    @State var favoritesVM: FavoritesViewModel = .init()
    var body: some View {
        InspirationTabView(favoritesVM: $favoritesVM)
    }
}

#Preview {
    InspirationTabViewPreview()
}

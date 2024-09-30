//
//  MenuView.swift
//  AI-generator
//
//  Created by Руслан Каприор on 18.09.2024.
//

import SwiftUI
import StoreKit


struct MenuView: View {
    let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    
    init () {
        if #available(iOS 16.0, *) {
        } else {
            UITableView.appearance().backgroundColor = .background
            UITableView.appearance().separatorColor = .background
            UITableView.appearance().sectionIndexBackgroundColor = .background
            
            var layoutConfig = UICollectionLayoutListConfiguration(appearance: .plain)
            layoutConfig.headerMode = .supplementary
            
            let listLayout = UICollectionViewCompositionalLayout.list(using: layoutConfig)
            UICollectionView.appearance().collectionViewLayout = listLayout
        }
    }
    
    @State var isOn = true
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            VStack {
                
                    List {
                        
                        Section {
                            Button(action: {
                                InAppPurchase.sharedInstance.restoreTransactions()
                            }, label: {
                                HStack {
                                    Image(systemName: "creditcard.fill")
                                        .renderingMode(.template)
                                        .foregroundColor(.textSelected)
                                    Text("Restore purchases")
                                }
                            }).applyListRowStyle()
                        }
                        
                        Section {
                            Button(action: {
                                let scenes = UIApplication.shared.connectedScenes
                                if let windowScene = scenes.first as? UIWindowScene {
                                    SKStoreReviewController.requestReview(in: windowScene)
                                }
                            }, label: {
                                HStack {
                                    Image(systemName: "star.fill")
                                        .renderingMode(.template)
                                        .foregroundColor(.textSelected)
                                    Text("Rate our app")
                                }
                            }).applyListRowStyle()
                            
                            ColoredNavigationLink(title: "Share with friends", systemName: "square.and.arrow.up.fill")
                            
                            Toggle(isOn: $isOn, label: {
                                HStack {
                                    Image(systemName: "app.badge.fill")
                                        .renderingMode(.template)
                                        .foregroundColor(.textSelected)
                                    Text("Notifications")
                                }
                            })
                            .font(.system(size: 14))
                            .padding(.vertical, 5)
                            .listRowBackground(
                                Rectangle()
                                    .background(Color.clear)
                                    .foregroundColor(.textGray)
                                    .opacity(0.04)
                            )
                            
                            Link(destination: URL(string: "https://docs.google.com/forms/d/e/1FAIpQLSewv0l2VYDz5N1YMU9P4wJku5Le4bxG27hXyET06Ds8u8BP5g/viewform?usp=sharing")!) {
                                HStack {
                                    Image(systemName: "envelope.open.fill")
                                        .renderingMode(.template)
                                        .foregroundColor(.textSelected)
                                    Text("Contact us")
                                }
                            }.applyListRowStyle()
                        }
                        
                        Section {
                            Link(destination: URL(string: "https://www.termsfeed.com/live/2c05aca8-6f47-4c8d-b738-9881ff09af4a")!) {
                                HStack {
                                    Image(systemName: "text.bubble.fill")
                                        .renderingMode(.template)
                                        .foregroundColor(.textSelected)
                                    Text("Usage policy")
                                }
                            }.applyListRowStyle()
                            
                            Link(destination: URL(string: "https://www.termsfeed.com/live/69a5772f-b2ce-44e8-aa46-8edaf0519a96")!) {
                                HStack {
                                    Image(systemName: "lock.fill")
                                        .renderingMode(.template)
                                        .foregroundColor(.textSelected)
                                    Text("Privacy policy")
                                }
                            }.applyListRowStyle()
                        }
                        
                        Section {
                            
                            
                            Text("App version \(appVersion)")
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.textGray)
                                .font(.system(size: 14, weight: .light))
                                .listRowBackground(
                                    Rectangle()
                                        .background(Color.clear)
                                        .foregroundColor(.background)
                                )
                                .opacity(0.5)
                        }
                        
                        
                    }.applyDarkScheme()
                
                
            }
        }
    }
}

#Preview {
    ZStack {
        Color.background.ignoresSafeArea()
        NavigationView {
            MenuView()
        }.preferredColorScheme(.dark)
    }
    
}

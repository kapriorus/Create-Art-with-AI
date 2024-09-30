//
//  PaywallView.swift
//  AI-generator
//
//  Created by Руслан Каприор on 14.09.2024.
//

import Foundation
import SwiftUI
import ApphudSDK


struct PaywallView: View {
    @Binding var isPresented: Bool
    
    private let paymentItems = [
        PaywallRadioButtonItem(title: "$4.99 / week", subtitle: "Monthly", price: "$19.99"),
        PaywallRadioButtonItem(title: "$1.87 / week", subtitle: "Yearly", price: "$39.99", isBestOffer: true)
    ]
    @State private var selectedPaymentItem: PaywallRadioButtonItem
    
    init(isPresented: Binding<Bool>) {
        selectedPaymentItem = paymentItems.first!
        _isPresented = isPresented
        
//        Apphud.fetchPlacements { placements, error in
//            // if placements are already loaded, callback will be invoked immediately
////            if let placement = placements.first(where: { $0.identifier == "default" }), let paywall = placement.paywall  {
////                let products = paywall.products
////                print(products)
////                  Apphud.paywallShown(paywall)
////                // setup your UI with these products
////            }
//        }
    }
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .top), content: {
            Image("paywallImage")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
                .offset(y: -50)
            
            
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [.clear, .background]), startPoint: .top, endPoint: .bottom))
                .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height/2 - 70)
            
            Rectangle()
                .foregroundColor(.background)
                .offset(y: UIScreen.main.bounds.height/2 - 70)
                .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height/2 + 70)
            
            HStack {
                Image(systemName: "xmark")
                    .opacity(0.8)
                    .frame(width: 30, height: 30)
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(.background)
                            .opacity(0.6)
                    )
                    .onTapGesture {
                        isPresented = false
                    }
                Spacer()
                Text("Restore").padding(10)
                    .font(.system(size: 14))
                    .opacity(0.8)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.background)
                            .opacity(0.6)
                    )
                    .onTapGesture {
                        InAppPurchase.sharedInstance.restoreTransactions()
                    }
            }.padding().offset(y: 50)
            
            ScrollView {
                BlueBadge(title: "PRO", icon: "crown.fill")
                Text("Convert Language Into Visual Art")
                    .font(.system(size: 34, weight: .bold))
                    .padding(.bottom, 1)
                    .padding(.horizontal, 10)
                    .multilineTextAlignment(.center)
                Text("Unlock all features with Pro")
                    .font(.system(size: 15))
                    .padding(.bottom, 20)
                    .opacity(0.8)
                ListItem(title: "Fast processing", image: "checkmark")
                ListItem(title: "Unlimited artwork creation", image: "checkmark")
                ListItem(title: "Increase image size by 2x", image: "checkmark")
                
                PaywallRadioButtonGroup(items: paymentItems, callback:  { selected in
                    selectedPaymentItem = selected
                }, selectedItem: selectedPaymentItem)
                
                
            }
            .offset(y: UIScreen.main.bounds.height/2 - 150)
            .frame(maxHeight: UIScreen.main.bounds.height/2 + 10)
            
            VStack {
                Spacer()
                
                BottomSheet(buttonText: "Continue", isBigBackground: true) {
                    InAppPurchase.sharedInstance.buy(type: selectedPaymentItem.subtitle)
                } bottomContent: {
                    HStack {
                        Link("Privacy Policy", destination: URL(string: "https://www.termsfeed.com/live/69a5772f-b2ce-44e8-aa46-8edaf0519a96")!)
                        Spacer()
                        Label("Cancel Anytime", systemImage: "clock")
                        Spacer()
                        Link("Terms of Use", destination: URL(string: "https://www.termsfeed.com/live/2c05aca8-6f47-4c8d-b738-9881ff09af4a")!)
                    }.font(.system(size: 12)).offset(y: 5).opacity(0.4)
                }
            }
            

            
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Rectangle().foregroundColor(Color("backgroundColor")))
        .foregroundColor(.white)
        .ignoresSafeArea()
    }
}

fileprivate struct PaywallViewPreview: View {
    @State var isPresented: Bool = true
    
    var body: some View {
        PaywallView(isPresented: $isPresented)
    }
}


#Preview {
    PaywallViewPreview()
}

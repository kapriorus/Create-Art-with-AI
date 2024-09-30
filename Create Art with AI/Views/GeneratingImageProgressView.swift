//
//  GeneratingImageProgressView.swift
//  AI-generator
//
//  Created by Руслан Каприор on 19.09.2024.
//

import SwiftUI

struct GeneratingImageProgressView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        
        ZStack(alignment: .top) {
            ZStack(alignment: .center) {
                Color.background.ignoresSafeArea()
                
                Image("createBgImg")
                    .resizable()
                    .ignoresSafeArea()
                
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                    .opacity(0.4)
                
                VStack(alignment: .center) {
//                    CircularProgressBar(progress: 0.2)
                    CircularLoader()
                    
                    Text("Generating your image")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                    
                    
                    Text("Hold it open and wait for the image to be created. It may take up to a minute to generate.")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 15, weight: .light))
                        .foregroundColor(.white)
                        .padding(.horizontal, 40)
                    
                    if !UserDefaults.standard.bool(forKey: "pro-unlocked") {
                        VStack(alignment: .center) {
                            Text("You want to go faster?")
                                .foregroundColor(.white)
                                .font(.system(size: 17, weight: .light))
                            
                            BlueBadge(title: "Upgrade to Pro", icon: "crown.fill")
                        }.frame(maxHeight: UIScreen.main.bounds.height / 4)
                    }
                }.frame(maxWidth: .infinity).padding(.top, 100)
                
            }
            
            HStack(alignment: .center) {
                Spacer()
                
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                    .opacity(0.4)
                    .onTapGesture {
                        isPresented.toggle()
                    }
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 30)
            .padding(.trailing, 30)
        }
    }
}

fileprivate struct GeneratingImageProgressViewPreview: View {
    @State var isPresented: Bool = true
    
    var body: some View {
        GeneratingImageProgressView(isPresented: $isPresented)
    }
}

#Preview {
    GeneratingImageProgressViewPreview()
}

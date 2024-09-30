//
//  TabsView.swift
//  AI-generator
//
//  Created by Руслан Каприор on 16.09.2024.
//

import SwiftUI

struct TabsView: View {
    var options: [String]
    @Binding var selection: String
    @Namespace private var namespace
    
    var body: some View {
        HStack {
            ForEach(options, id: \.self) { option in
                VStack {
                    Text(option)
                        .font(.system(size: 20, weight: .bold))
                        .opacity(selection == option ? 1 : 0.5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .offset(y: 20)
                                .frame(height: 1)
                                .opacity(selection == option ? 1 : 0)
                                .foregroundColor(.textSelected)
                        )
                        .foregroundColor(.textGray)
                }
                .onTapGesture {
                    withAnimation {
                        selection = option
                    }
                }
            }
        }
    }
}

fileprivate struct TabsViewPreview: View {
    var options: [String] = ["Inspirations", "Recents"]
    @State var selection: String  = "Inspirations"
    
    var body: some View {
        TabsView(options: options, selection: $selection)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        TabsViewPreview()
    }
}

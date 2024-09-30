//
//  PaywallRadioButtonGroup.swift
//  AI-generator
//
//  Created by Руслан Каприор on 18.09.2024.
//

import SwiftUI

struct PaywallRadioButton: View {

    let item: PaywallRadioButtonItem
    let callback: (PaywallRadioButtonItem)->()
    let selectedItem : PaywallRadioButtonItem
    let size: CGFloat
    let color: Color
    let textSize: CGFloat

    init(
        _ item: PaywallRadioButtonItem,
        callback: @escaping (PaywallRadioButtonItem)->(),
        selectedItem: PaywallRadioButtonItem,
        size: CGFloat = 20,
        color: Color = Color.white,
        textSize: CGFloat = 14
        ) {
        self.item = item
        self.size = size
        self.color = color
        self.textSize = textSize
        self.selectedItem = selectedItem
        self.callback = callback
    }

    var body: some View {
        Button(action:{
            self.callback(self.item)
        }) {
            HStack(alignment: .center, spacing: 10) {
                
                Image(systemName: self.selectedItem == self.item ? "checkmark.circle.fill" : "circle")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: self.size, height: self.size)
                    .foregroundColor(self.selectedItem == self.item ? .textSelected : .textGray)
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 0) {
                        Text(item.subtitle)
                            .font(Font.system(size: textSize))
                            .opacity(0.8)
                        
                        Text("・")
                            .opacity(0.4)
                        
                        Text(item.price)
                            .font(Font.system(size: textSize))
                            .opacity(0.4)
                    }.padding(0)
                    HStack {
                        Text(item.title)
                            .font(Font.system(size: textSize))
                        
                        if item.isBestOffer {
                            BlueBadge(title: "best offer")
                        }
                    }.padding(0)
                }
                
                Spacer()
                
            }
            .foregroundColor(self.color)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.textGray)
                    .opacity(0.1)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.textSelected, lineWidth: self.selectedItem == self.item ? 1 : 0)
            )
        }
        .foregroundColor(self.color)
    }
}

struct PaywallRadioButtonGroup: View {

    let items : [PaywallRadioButtonItem]
    let callback: (PaywallRadioButtonItem) -> ()

    @State var selectedItem: PaywallRadioButtonItem = .init(title: "", subtitle: "", price: "")

    

    var body: some View {
        VStack {
            ForEach(items, id: \.self) { item in
                PaywallRadioButton(item, callback: self.radioGroupCallback, selectedItem: self.selectedItem)
            }
        }.padding()
    }

    func radioGroupCallback(item: PaywallRadioButtonItem) {
        selectedItem = item
        callback(item)
    }
}

#Preview {
    ZStack {
        Color.background.ignoresSafeArea()
        PaywallRadioButtonGroup(items: [
            PaywallRadioButtonItem(title: "$4.99 / week", subtitle: "Monthly", price: "$19.99"),
            PaywallRadioButtonItem(title: "$1.87 / week", subtitle: "Yerly", price: "$39.99", isBestOffer: true)
        ]) { item in
            
        }
    }
    
}

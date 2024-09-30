//
//  MainBoardStylesView.swift
//  AI-generator
//
//  Created by Руслан Каприор on 15.09.2024.
//

import SwiftUI

struct HorizontalItems: View {
    @Binding var selected: StyleType
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(StyleType.allCases, id: \.rawValue) { item in
                    HorizontalItemsCell(title: item.rawValue, isSelected: selected == item)
                        .onTapGesture {
                            withAnimation {
                                selected = item
                            }
                        }
                }
            }
            .padding(1)
        }
    }
}

struct HorizontalItemsCell: View {
    var title: String
    var isSelected: Bool
    
    var body: some View {
        Text(title)
            .padding(.vertical, 10)
            .padding(.horizontal, 15)
            .background(
                Capsule(style: .circular)
                    .stroke(lineWidth: 1.0)
                    .foregroundColor(isSelected ? Color.borderSelected : Color.textfieldBorder)
                    .background(isSelected ? RoundedRectangle(cornerRadius: 25.0).frame(maxWidth: .infinity, maxHeight: .infinity).foregroundColor(.backgroundSelected).opacity(0.2) : nil)
            )
            .foregroundColor(Color.textGray)
    }
}

fileprivate struct HorizontalItemsPreview: View {
    
    @State private var selected: StyleType = StyleType(rawValue: StyleType.allCases[0].rawValue) ?? .none
    
    var body: some View {
        HorizontalItems(selected: $selected)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        HorizontalItemsPreview()
    }
    
}

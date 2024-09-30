//
//  Main.swift
//  AI-generator
//
//  Created by Руслан Каприор on 18.09.2024.
//

import SwiftUI


struct TextBlock: View {
    @State var text: String
    @State var title: String = ""
    @State var fullWidth: Bool = false
    
    var body: some View {
        VStack(alignment: .leading,spacing: 10) {
            if !title.isEmpty {
                Text(title)
                    .font(.system(size: 12))
            }
            
            Text(text)
                .font(.system(size: 17, weight: .semibold))
        }
        .frame(maxWidth: fullWidth ? .infinity : nil, alignment: .leading)
        .opacity(0.6)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 14)
                .foregroundColor(Color.textGray)
                .opacity(0.1)
        )
    }
}


struct BlueButton: View {
    var text: String
    var icon: String = ""
    var fullWidth: Bool = true
    var isSmall: Bool = false
    var function: () -> Void
    
    var body: some View {
        Button {
            self.function()
        } label: {
            HStack(spacing: 0) {
                if icon == "swirl.circle.righthalf.filled" {
                    if #available(iOS 17.0, *) {
                        Image(systemName: "swirl.circle.righthalf.filled")
                            .padding(.trailing, 5)
                    } else {
                        Image("swirl.circle.righthalf.filled")
                            .renderingMode(.template)
                            .padding(.trailing, 5)
                    }
                } else {
                    Image(systemName: icon)
                        .padding(.trailing, 5)
                }
                
                Text(text)
            }.frame(maxWidth: fullWidth ? .infinity: nil, maxHeight: 20)
                .padding(isSmall ? 10 : 20)
        }
        .buttonStyle(BlueButtonStyle())
    }
}


struct PlaceholderTextEditor: View {
    var placeholder: String
    @Binding var text: String
    var height: CGFloat
    
    init(placeholder: String, text: Binding<String>, height: CGFloat = 100) {
        self.placeholder = placeholder
        _text = text
        self.height = height
        
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty && height > 0 {
                Text(placeholder)
                    .background(Color.clear)
                    .padding(.top, 15)
                    .padding(.leading, 10)
                    .opacity(0.6)
            }
            
            if #available(iOS 16.0, *) {
                TextEditor(text: $text)
                    .applyDefaultStyle(height: height)
                    .scrollContentBackground(.hidden)
            } else {
                TextEditor(text: $text)
                    .applyDefaultStyle(height: height)
            }
        }
    }
}


struct ColoredNavigationLink: View {
    var title: String
    var systemName: String
    
    var body: some View {
        NavigationLink(destination: Text("Hello, World!")) {
            Image(systemName: systemName)
                .renderingMode(.template)
                .foregroundColor(.textSelected)
            Text(title)
        }

        .applyListRowStyle()
    }
}



struct CollapsedBlock<Content: View>: View {
    var title: String
    @ViewBuilder var content: () -> Content
    
    @State private var collapsed: Bool = true
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .padding(.vertical, 5)
                    .font(.system(size: 17, weight: .bold))
                
                Spacer()
                Text(collapsed ? "Open" : "Collapse")
                    .font(.system(size: 17, weight: .light))
                Image(systemName: "chevron.down")
                    .foregroundColor(.textSelected)
                    .animation(.easeInOut)
                    .rotationEffect(
                        .degrees(collapsed ? 0 : -180)
                    )
                    
            }
            .onTapGesture {
                withAnimation {
                    collapsed.toggle()
                }
            }
            
            if !collapsed {
                content()
            }
        }
        .frame(maxWidth: .infinity, minHeight: 0, maxHeight: collapsed ? 30 : .infinity, alignment: .topLeading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.textfieldBorder, lineWidth: 0.4)
        )

    }
}


struct ListItem: View {
    var title: String
    var image: String
    
    var body: some View {
        Label(title: {
            Text(title)
        }) {
            Image(systemName: image)
                .renderingMode(.template)
                .foregroundColor(.textSelected)
        }
        .padding(.bottom, 10)
    }
}

struct BlueBadge: View {
    var title: String
    var icon: String = ""
    
    var body: some View {
        HStack {
            if !icon.isEmpty {
                Image(systemName: icon)
            }
            
            Text(title)
                .textCase(.uppercase)
                .font(.system(size: icon.isEmpty ? 11 : 17, weight: .bold))
                
        }.padding(5)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.primaryGradientEnd, Color.primaryGradientStart]), startPoint: .leading, endPoint: .trailing)
            )
            .foregroundColor(Color.primaryGradientText)
            .clipShape(Capsule())
        
    }
}


struct BottomSheet<Content: View>: View {
    var buttonText: String
    var icon: String = ""
    @State var disabled: Bool = false
    var isBackgroundVisible: Bool = true
    var isBigBackground: Bool = false
    var onClick: () -> Void
    @ViewBuilder var bottomContent: () -> Content?
    
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
            if isBackgroundVisible {
                Rectangle().foregroundColor(Color.backgroundGray).ignoresSafeArea()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: isBigBackground ? 140 : 120, alignment: .center).zIndex(-1)
            }
            
            
            VStack {
                BlueButton(text: buttonText, icon: icon) {
                    self.onClick()
                }.disabled(disabled)
                
                bottomContent()
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: isBigBackground ? 70 : 80, alignment: .center)
            .padding()
        }
    }
}

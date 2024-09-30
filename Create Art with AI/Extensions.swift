//
//  Extensions.swift
//  AI-generator
//
//  Created by Руслан Каприор on 18.09.2024.
//

import SwiftUI



extension Text {
    func applyCardStyle(isTitle: Bool = false) -> some View {
        self.multilineTextAlignment(.center)
            .font(.system(size: isTitle ? 28 : 15, weight: isTitle ? .bold : .regular))
            .padding(EdgeInsets(top: 1, leading: 10, bottom: 0, trailing: 10))
    }
}


extension TextEditor {
    func applyDefaultStyle(height: CGFloat = 100) -> some View {
        self.frame(maxWidth: .infinity, minHeight: height, maxHeight: height, alignment: .topLeading)
            .padding(height > 0 ? 5 : 0)
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color.textfieldBorder, lineWidth: 0.2)
            )
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .foregroundColor(Color.background.opacity(0.5))
            )
            
    }
}


struct OldListModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color.background)
            .foregroundColor(.white)
            .font(.system(size: 17))
    }
}
@available(iOS 16, *)
struct NewListModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scrollContentBackground(.hidden)
            .background(Color.background)
            .foregroundColor(.white)
            .font(.system(size: 17))
    }
}
extension View {
    @ViewBuilder
    func applyDarkScheme() -> some View {
        if #available(iOS 16, *) {
            self
                .modifier(NewListModifier())
        }
        else {
            self.modifier(OldListModifier())
        }
    }
}

extension UIView {
    func allSubviews() -> [UIView] {
        var allSubviews = subviews
        for subview in subviews {
            allSubviews.append(contentsOf: subview.allSubviews())
        }
        return allSubviews
    }
}

extension UITabBar {
    private static var originalY: Double?
    
    static public func changeTabBarState(shouldHide: Bool) {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        windowScene?.windows.first(where: { $0.isKeyWindow })?.allSubviews().forEach({ view in
            if let tabBar = view as? UITabBar {
                if !tabBar.isHidden && shouldHide {
                    originalY = (tabBar.superview?.frame.origin.y)!
                    tabBar.superview?.frame.origin.y = (tabBar.superview?.frame.origin.y)! + 4.5
                } else if tabBar.isHidden && !shouldHide {
                    guard let originalY else {
                        return
                    }
                    tabBar.superview?.frame.origin.y = originalY
                }
                tabBar.isHidden = shouldHide
                tabBar.superview?.setNeedsLayout()
                tabBar.superview?.layoutIfNeeded()
            }
        })
    }
}

extension Binding {
    func onUpdate(_ closure: @escaping () -> Void) -> Binding<Value> {
        Binding(get: {
            wrappedValue
        }, set: { newValue in
            wrappedValue = newValue
            closure()
        })
    }
}

extension View {
    func applyListRowStyle() -> some View {
        return self
            .font(.system(size: 14))
            .padding(.vertical, 10)
            .listRowBackground(
                Rectangle()
                    .background(Color.clear)
                    .foregroundColor(.textGray)
                    .opacity(0.04)
            )
    }
}

extension String {
    func withoutEmoji() -> String {
        filter { $0.isASCII }
    }
}

extension Binding {
     func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}

//
//  CreativityTabView.swift
//  AI-generator
//
//  Created by Руслан Каприор on 18.09.2024.
//

import SwiftUI

struct CreativityTabView: View  {
    @Binding var favoritesVM: FavoritesViewModel
    
    
    @State private var promptText: String = ""

    @State private var selectedStyle: StyleType = StyleType(rawValue: StyleType.allCases[0].rawValue) ?? .none
    
    @State private var isNegativeWordsVisible: Bool = false
    @State private var negativeWords: String = ""
    
    @State private var filters: [String] = ["Inspirations", "Recents"]
    @State private var filterSelection: String  = "Inspirations"
    
    @State private var images: [FetchDataResult] = CONSTANTS.MOCKED_IMAGES
    
    @State private var isGenerationModalShown: Bool = false
    @State private var isResultModalShown: Bool = false
    @State private var isPaywallModalShown: Bool = false
    
    @StateObject var viewModel = GeneratedImagesViewModel()
    
    @AppStorage("pro-unlocked") var isUnlocked: Bool = false
    
    init(favoritesVM: Binding<FavoritesViewModel>) {
        _favoritesVM = favoritesVM
        UITextView.appearance().backgroundColor = .clear
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    
    var body: some View {
        
        NavigationView {
            
            ZStack(alignment: .topLeading) {
                Color.background.ignoresSafeArea()
                
                Image("createBgImg").ignoresSafeArea()
                
                
                ScrollView {
                    
                    
                    VStack(alignment: .leading, spacing: 15) {
                        
                        Text("Enter Prompt")
                            .font(.system(size: 17, weight: .bold))
                        PlaceholderTextEditor(placeholder: "What do you want to generate?", text: $promptText)
                        
                        
                        
                        Text("Style")
                            .font(.system(size: 17, weight: .bold))
                        HorizontalItems(selected: $selectedStyle)
                        
                        //                            HStack {
                        //                                Text("Negative Words")
                        //                                    .font(.system(size: 17, weight: .bold))
                        //                                Text("Optional")
                        //                                    .font(.system(size: 10))
                        //                                    .offset(y: -2)
                        //                                    .foregroundColor(.textGray)
                        //                                    .opacity(0.8)
                        //                                
                        //                                Spacer()
                        //                                
                        //                                Text(isNegativeWordsVisible ? "Collapse" : "Open")
                        //                                    .font(.system(size: 15))
                        //                                    .foregroundColor(.textGray)
                        //                                    .opacity(0.8)
                        //                                    .transition(.move(edge: .top))
                        //                                Image(systemName: "chevron.down")
                        //                                    .foregroundColor(.textSelected)
                        //                                    .animation(.easeInOut)
                        //                                    .rotationEffect(
                        //                                        .degrees(isNegativeWordsVisible ? -180 : 0)
                        //                                    )
                        //                                
                        //                            }
                        //                            .onTapGesture {
                        //                                withAnimation(.easeInOut(duration: 0.3)) {
                        //                                    isNegativeWordsVisible.toggle()
                        //                                }
                        //                                
                        //                            }
                        //                            PlaceholderTextEditor(
                        //                                placeholder: "Use negative words like \"blue\" to get less blue color",
                        //                                text: $negativeWords,
                        //                                height: isNegativeWordsVisible ? 100 : 0
                        //                            )
                        //                            
                        
                        
                        
                        BlueButton(text: "Create", icon: "swirl.circle.righthalf.filled") {
                            isGenerationModalShown = true
                            generateImages()
                        }.disabled(promptText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                            .onReceive(viewModel.$images, perform: { result in
                                if result.count > 0 {
                                    isGenerationModalShown = false
                                    isResultModalShown = true
                                }
                            })
                            .fullScreenCover(isPresented: $isGenerationModalShown) {
                                GeneratingImageProgressView(isPresented: $isGenerationModalShown)
                            }
                            .fullScreenCover(isPresented: $isResultModalShown) {
                                GeneratedImagesView(
                                    prompt: promptText,
                                    images: $viewModel.images,
                                    isPresented: $isResultModalShown,
                                    favoritesVM: $favoritesVM
                                ) {
                                    isResultModalShown = false
                                    isGenerationModalShown = true
                                    generateImages()
                                }
                            }
                        
                        
                        TabsView(options: filters, selection: $filterSelection)
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        ImagesView(images: $images, favoritesVM: $favoritesVM)
                        
                        
                    }
                    .padding(20)
                    
                }
                .navigationBarTitle("Creativity")
                .preferredColorScheme(.dark)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack {
                            if !isUnlocked {
                                BlueButton(text: "PRO", icon: "crown", isSmall: true) {
                                    self.isPaywallModalShown.toggle()
                                }
                                .fullScreenCover(isPresented: self.$isPaywallModalShown) {
                                    PaywallView(isPresented: self.$isPaywallModalShown)
                                }
                                .scaleEffect(0.8)
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
    
    private func generateImages() {
        Task {
            do {
                try await viewModel.generate(
                    for: promptText,
                    style: selectedStyle.rawValue.withoutEmoji().lowercased(),
                    with: negativeWords
                )
            } catch {
                
            }
        }
    }
}


fileprivate struct CreativityTabViewPreview: View {
    @State var favoritesVM: FavoritesViewModel = .init()
    var body: some View {
        CreativityTabView(favoritesVM: $favoritesVM)
    }
}

#Preview {
    CreativityTabViewPreview()
}

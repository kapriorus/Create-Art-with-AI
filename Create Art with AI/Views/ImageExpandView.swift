//
//  ImageExpandView.swift
//  AI-generator
//
//  Created by Руслан Каприор on 17.09.2024.
//

import SwiftUI

struct ImageExpandView: View {
    var image: FetchDataResult
    var prompt: String
    @Binding var images: [FetchDataResult]
    @Binding var favoritesVM: FavoritesViewModel
    @State private var loadedImage: UIImage?
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            VStack(spacing: 0) {
                ScrollView(.vertical) {
                    VStack(alignment: .leading) {
                        
                        ZStack(alignment: .top) {
                            ImageView(withURL: image.url!, and: image.id!, favoritesVM: $favoritesVM, topBarItems: true, loadedImage: $loadedImage)
                                .cornerRadius(40)
                                .preferredColorScheme(.dark)
                                .frame(width: UIScreen.main.bounds.width - 30, height: UIScreen.main.bounds.width - 30)
                                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.width)
                            
                        }
                        
                        HStack {
                            Text("Prompt")
                                .font(.system(size: 17, weight: .bold))
                            
                            Spacer()
                            
                            Text("Copy")
                                .font(.system(size: 17, weight: .light))
                                .onTapGesture {
                                    UIPasteboard.general.string = prompt
                                }
                            Image(systemName: "doc.on.doc")
                                .renderingMode(.original)
                                .foregroundColor(.textSelected)
                        }
                        
                        TextBlock(text: prompt, fullWidth: true)
                        
                        
                        CollapsedBlock(title: "Details") {
                            VStack(alignment: .leading) {
                                //                            Text("Negative prompt")
                                //                                .font(.system(size: 17, weight: .bold))
                                //                                .opacity(0.5)
                                //                            TextBlock(text: prompt)
                                //
                                
                                
                                //                            Text("Details")
                                //                                .font(.system(size: 17, weight: .bold))
                                //                                .opacity(0.5)
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        TextBlock(text: "1024x1024", title: "Image size")
                                        
                                        TextBlock(text: "Upscaled", title: "Resolution")
                                        
                                        TextBlock(text: "Art", title: "Model")
                                        
                                        TextBlock(text: "1:1 - landscape", title: "Aspect ratio")
                                    }
                                }
                            }
                        }
                        
                        Text("More images like this")
                            .padding(.top, 30)
                            .font(.system(size: 17, weight: .bold))
                        ImagesView(images: $images, favoritesVM: $favoritesVM)
                    }.padding()
                }
                
                BottomSheet(buttonText: "Share", icon: "square.and.arrow.up") {
                    if loadedImage != nil {
                        let shareImage = UIActivityViewController(activityItems: [loadedImage!], applicationActivities: nil)
                        
                        if let viewController = UIApplication.shared.windows.last?.rootViewController {
                            viewController.present(shareImage, animated: true, completion: nil)
                        }
                    }
                } bottomContent: {
                    
                }.disabled(loadedImage == nil)
                
            }
        }.navigationBarTitleDisplayMode(.inline)
    }
}

fileprivate struct ImageExpandViewPreview: View {
    @State var image: String = "paywallImage"
    @State var prompt: String = "abstract knife painting of geometric kasmiri face on fire and water in zao wou-"
    @State var images: [FetchDataResult] = CONSTANTS.MOCKED_IMAGES
    @State var favoritesVM: FavoritesViewModel = .init()
    
    var body: some View {
        ImageExpandView(
            image: FetchDataResult(id: "0", url: "https://cdn.apiframe.pro/images/31163383913893365614255687448879-1.png"),
            prompt: prompt,
            images: $images,
            favoritesVM: $favoritesVM
        )
    }
}

#Preview {
    ZStack {
        Color.background.ignoresSafeArea()
        ImageExpandViewPreview()
            .foregroundColor(.white)
    }
}

//
//  CreativityTabImagesView.swift
//  AI-generator
//
//  Created by Руслан Каприор on 16.09.2024.
//

import SwiftUI

struct ImagesView: View {
    var prompt: String?
    @Binding var images: [FetchDataResult]
    @Binding var favoritesVM: FavoritesViewModel
    
    var body: some View {
            ScrollView {
                
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: UIScreen.main.bounds.width/2 - 30))]) {
                    ForEach(images, id: \.self) { item in
                        let defaultPrompt: String = "abstract knife painting of geometric kasmiri face on fire and water in zao wou-"
                        
                        
                        NavigationLink(destination: ImageExpandView(image: item, prompt: prompt ?? defaultPrompt, images: $images, favoritesVM: $favoritesVM).foregroundColor(.white)) {
                            ImageView(withURL: item.url!, and: item.id!, favoritesVM: $favoritesVM)
                                .frame(width: UIScreen.main.bounds.width/2 - 30, height: UIScreen.main.bounds.width/2 - 30)
                                .cornerRadius(10)
                        }
                    }
                }
                
            }
        
        
    }
    
}

fileprivate struct ImagesViewPreview: View {
    @State private var images = [
        FetchDataResult(id: "0", url: "https://cdn.apiframe.pro/images/31163383913893365614255687448879-1.png"),
        FetchDataResult(id: "1", url: "https://cdn.apiframe.pro/images/31163383913893365614255687448879-2.png"),
        FetchDataResult(id: "2", url: "https://cdn.apiframe.pro/images/31163383913893365614255687448879-3.png"),
        FetchDataResult(id: "3", url: "https://cdn.apiframe.pro/images/31163383913893365614255687448879-4.png")
    ]
    @State var favoritesVM: FavoritesViewModel = .init()
    
    var body: some View {
        ImagesView(images: $images, favoritesVM: $favoritesVM)
    }
}

#Preview {
    ImagesViewPreview()
}

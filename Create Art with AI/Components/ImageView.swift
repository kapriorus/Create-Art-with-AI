//
//  ImageView.swift
//  AI-generator
//
//  Created by Руслан Каприор on 25.09.2024.
//

import SwiftUI
import Combine


class ImageLoader: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }

    init(urlString:String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, self != nil else { return }
            DispatchQueue.main.async {
                self?.data = data
            }
        }
        task.resume()
    }
}

struct ImageView: View {
    @ObservedObject var imageLoader:ImageLoader
    
    var topBarItems: Bool = false
    @State var image: UIImage?
    var resultId: String
    @Binding var imageLoaded: UIImage?
    @Binding var favoritesVM: FavoritesViewModel
    
    private var imageURL = ""

    init(withURL url:String,
         and resultId: String, favoritesVM:Binding<FavoritesViewModel>, topBarItems:Bool = false, loadedImage: Binding<UIImage?>? = nil) {
        imageLoader = ImageLoader(urlString:url)
        _favoritesVM = favoritesVM
        self.resultId = resultId
        imageURL = url
        self.topBarItems = topBarItems
        self._imageLoaded = loadedImage ?? Binding.constant(nil)
    }

    var body: some View {
        let isImageFavorite: Bool = isFavorite()
        
        ZStack(alignment: .center) {
            Color.backgroundGray
            
            
            Rectangle()
                .foregroundColor(Color.backgroundGray)
                .onReceive(imageLoader.didChange) { data in
                    let image: UIImage = UIImage(data: data) ?? UIImage()
                    self.image = image
                    self.imageLoaded = image
                }
            
            ProgressView()
            
            ZStack(alignment: .top) {
                if image != nil {
                    Image(uiImage: image!)
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    
                    if topBarItems || isImageFavorite {
                        HStack {
                            if topBarItems {
                                Image(systemName: "arrow.down.to.line")
                                    .frame(width: 40, height: 40)
                                    .background(
                                        RoundedRectangle(cornerRadius: 30)
                                            .foregroundColor(.background)
                                            .opacity(0.8)
                                    )
                                    .onTapGesture {
                                        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
                                    }
                            }
                            Spacer()
                            Image(systemName: isImageFavorite ? "star.fill" : "star")
                                .renderingMode(.template)
                                .frame(width: 40, height: 40)
                                .background(
                                    RoundedRectangle(cornerRadius: 30)
                                        .foregroundColor(.background)
                                        .opacity(0.8)
                                )
                                .foregroundColor(isImageFavorite ? .starActive : .primary)
                                .onTapGesture {
                                    Task {
                                        await favoritesVM.mark(for: resultId)
                                    }
                                }
                                .offset(
                                    x: !topBarItems && isImageFavorite ? 10 : 0,
                                    y: !topBarItems && isImageFavorite ? -10 : 0
                                )
                        }.padding()
                    }
                    
                }
            }
            
        }
    }
    
    private func isFavorite() -> Bool {
        var result = false
        
        for item in favoritesVM.images {
            if resultId == item.id {
                result = true
                break
            }
        }
        
        return result
    }
}

fileprivate struct ImageViewPreview: View {
    @State var favoritesVM: FavoritesViewModel = .init()
    
    var body: some View {
        
        ZStack {
            Color.background.ignoresSafeArea()
            
            ImageView(
                withURL: "https://cdn.apiframe.pro/images/31163383913893365614255687448879-4.png",
                and: "",
                favoritesVM: $favoritesVM,
                topBarItems: true
            )
            .frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.width/2)
        }
    }
}

#Preview {
    ImageViewPreview()
}

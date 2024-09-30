//
//  GeneratedImagesViewModel.swift
//  AI-generator
//
//  Created by Руслан Каприор on 25.09.2024.
//

import Foundation

class GeneratedImagesViewModel: ObservableObject {
    @MainActor @Published var error = ""
    @MainActor @Published var images: [FetchDataResult] = []
    
    
    
    func generate(for prompt: String, style: String, with negotiateWords: String) async throws {
        await MainActor.run {
            self.error = ""
        }
        
//        try await Task.sleep(nanoseconds: 1000000000 * 5)
//        await MainActor.run {
//            self.images = [FetchDataResult.init(id: UUID().uuidString, url:"https://cdn.apiframe.pro/images/31163383913893365614255687448879-2.png")]
//        }
        
        if let requestId = await NetworkAPI.generateImages(for: prompt, style: style, with: negotiateWords) {
            var items: [FetchDataResult]? = nil
            while items == nil {
                guard let response: FetchData = await NetworkAPI.getImages(for: requestId) else {
                    items = []
                    await MainActor.run {
                        self.error = "Fetch data failed"
                    }
                    return
                }
                
                if response.status == "complete" {
                    items = response.result
                    await MainActor.run {
                        self.images = response.result!
                    }
                }
    
                try await Task.sleep(nanoseconds: 1000000000 * 5)
            }
        } else {
            await MainActor.run {
                self.error = "Fetch data failed"
            }
        }
    }
}

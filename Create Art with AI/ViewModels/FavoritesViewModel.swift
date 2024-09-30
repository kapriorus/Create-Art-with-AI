//
//  FavoritesViewModel.swift
//  AI-generator
//
//  Created by Руслан Каприор on 27.09.2024.
//

import Foundation

class FavoritesViewModel: ObservableObject, Observable {
    @MainActor @Published var error = ""
    @MainActor @Published var images: [FetchDataResult] = []
    
    
    func mark(for resultId: String) async {
        
        await MainActor.run {
            self.error = ""
        }
        
        if let response = await NetworkAPI.markAsFavorite(for: resultId){
            await MainActor.run {
                self.images = response
            }
        } else {
            await MainActor.run {
                self.error = "Fetch data failed"
            }
        }
        
    }
    
    func getList() async {
        
        await MainActor.run {
            self.error = ""
        }
    
        if let response = await NetworkAPI.getFavorites(){
            await MainActor.run {
                self.images = response
            }
        } else {
            await MainActor.run {
                self.error = "Fetch data failed"
            }
        }
        
    }
}

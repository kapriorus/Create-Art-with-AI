//
//  NetworkAPI.swift
//  AI-generator
//
//  Created by Руслан Каприор on 25.09.2024.
//

import Foundation
import UIKit

class NetworkAPI {
    
    static func markAsFavorite(for resultId: String) async -> [FetchDataResult]? {
        do {
            let data = try await NetworkLayer.shared.get(
                path: "/api/v2/favourite", method: .post, parameters: [
                    "userId": CONSTANTS.USER_ID,
                    "resultId": resultId,
                ]
            )
            let result: FavoritesResponse = try self.parseData(data: data)
            
            if result.error == nil || (result.error ?? false) {
                return nil
            } else {
                return result.data

            }
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    
    static func getFavorites() async -> [FetchDataResult]? {
        do {
            let data = try await NetworkLayer.shared.get(
                path: "/api/v2/favourites", method: .get, parameters: [
                    "userId": CONSTANTS.USER_ID,
                ]
            )
            let result: FavoritesResponse = try self.parseData(data: data)
            
            if result.error == nil || (result.error ?? false) {
                return nil
            } else {
                return result.data

            }
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    
    static func generateImages(for prompt: String, style: String, with negotiateWords: String) async -> String? {
        var fullPrompt: String = prompt + " in " + style + " style"
        if !negotiateWords.isEmpty {
            fullPrompt += " no \(negotiateWords)"
        }
        do {
            let data = try await NetworkLayer.shared.get(
                path: "/api/v2/generate", method: .post, parameters: [
                    "profileId": CONSTANTS.PROFILE_ID,
//                    "userId": UIDevice.current.identifierForVendor!.uuidString,
                    "userId": 111122233,
                    "prompt": fullPrompt,
                    "lang": CONSTANTS.LANGUAGE
                ]
            )
            let result: ImagineResponse = try self.parseData(data: data)
            
            if result.error == nil || (result.error ?? false) {
                return nil
            } else {
                return result.data?.requestId

            }
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    static func getImages(for requestId: String) async -> FetchData? {
        do {
            let data = try await NetworkLayer.shared.get(path: "/api/v2/result?requestId=\(requestId)", method: .get, parameters: nil)
            let result: FetchResponse = try self.parseData(data: data)
            
            if result.error == nil || (result.error ?? false) {
                return nil
            } else {
                return result.data

            }
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }

    private static func parseData<T: Decodable>(data: Data) throws -> T{
        guard let decodedData = try? JSONDecoder().decode(T.self, from: data)
        else {
            throw NSError(
                domain: "NetworkAPIError",
                code: 3,
                userInfo: [NSLocalizedDescriptionKey: "JSON decode error"]
            )
        }
        return decodedData
    }
}

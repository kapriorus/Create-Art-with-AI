//
//  NetworkLayer.swift
//  AI-generator
//
//  Created by Руслан Каприор on 25.09.2024.
//

import Foundation
import Alamofire

actor NetworkLayer: GlobalActor {
    static let shared = NetworkLayer()
    private init() {}

    func get(path: String, method: HTTPMethod, parameters: Parameters?) async throws -> Data {
       // You must resume the continuation exactly once
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                CONSTANTS.API_BASE_URL + path,
                method: method,
                parameters: parameters
//                headers: commonHeaders,
            )
            .responseData { response in
                switch(response.result) {
                case let .success(data):
                    continuation.resume(returning: data)
                case let .failure(error):
                    continuation.resume(throwing: self.handleError(error: error))
                }
            }
        }
    }

    private func handleError(error: AFError) -> Error {
        if let underlyingError = error.underlyingError {
            let nserror = underlyingError as NSError
            let code = nserror.code
            if code == NSURLErrorNotConnectedToInternet ||
                code == NSURLErrorTimedOut ||
                code == NSURLErrorInternationalRoamingOff ||
                code == NSURLErrorDataNotAllowed ||
                code == NSURLErrorCannotFindHost ||
                code == NSURLErrorCannotConnectToHost ||
                code == NSURLErrorNetworkConnectionLost
            {
                var userInfo = nserror.userInfo
                userInfo[NSLocalizedDescriptionKey] = "Unable to connect to the server"
                let currentError = NSError(
                    domain: nserror.domain,
                    code: code,
                    userInfo: userInfo
                )
                return currentError
            }
        }
        return error
    }
}

//actor NetworkLayer: GlobalActor {
//    static let shared = NetworkLayer()
//    
//    func generateImages(for prompt: String, style: String, with negotiateWords: String, completion: @escaping ([String], Error?) -> Void) {
//        generateImage(for: prompt, style: style, with: negotiateWords) { requestId, error in
//            
//            self.getImage(for: requestId!) { image, error in
//                
//            }
//        }
//    }
//    
//    private func getImage(for requestId: String, completion: @escaping (String?, Error?) -> Void) {
//        AF.request(CONSTANTS.FETCH_IMAGE_URL(for: requestId), method: .get).responseJSON { response in
//            let responseData = String(data: response.data!, encoding: String.Encoding.utf8)
//            
//            switch response.result {
//            case .success:
//            }
//        }
//    }
//    
//    
//    private func generateImage(for prompt: String, style: String, with negotiateWords: String, completion: @escaping (String?, Error?) -> Void) {
//        AF.request(CONSTANTS.GENERATE_IMAGE_URL(for: prompt, style: style, with: negotiateWords), method: .post).responseJSON { response in
//            let responseData = String(data: response.data!, encoding: String.Encoding.utf8)
//            
//            switch response.result {
//            case .success:
//                guard let data = response.data else {
//                    completion(nil, NSError(domain: "app.error.generateImage.data", code: 0, userInfo: ["response": responseData ?? []]))
//                    return
//                }
//                
//                do {
//                    let responseDecoded = try JSONDecoder().decode(ImagineResponse.self, from: data)
//                    
//                    guard let requestId = responseDecoded.data?.requestId else {
//                        completion(nil, NSError(domain: "app.error.generateImage.requestId", code: 0, userInfo: ["response": responseDecoded]))
//                        return
//                    }
//                    
//                    completion(responseDecoded.data!.requestId ?? "", nil)
//                } catch let error as NSError{
//                    completion(nil, NSError(domain: "app.error.generateImage.decoding", code: 0, userInfo: ["response": responseData ?? [], "error": error]))
//                    return
//                }
//                
//            
//            case .failure(let error):
//                completion(nil, NSError(domain: "app.error.generateImage.response", code: 0, userInfo: ["response": responseData ?? [], "error": error]))
//                return
//            }
//                        
//        }
//    }
//
//}

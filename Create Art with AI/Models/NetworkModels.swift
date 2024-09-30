//
//  NetworkModels.swift
//  AI-generator
//
//  Created by Руслан Каприор on 25.09.2024.
//

import Foundation



/*
 
 {
     "error": false,
     "data": {
         "requestId": "8b0e3314-c7b7-42d2-b109-74e3798e40cd",
         "status": "processing",
         "error": null,
         "request": {
             "profileId": 5,
             "app": "ai",
             "version": "1.0",
             "userPrompt": "sun",
             "productionPrompt": "sun",
             "ai": "apiframe"
         },
         "result": []
     }
 }
 
 */
struct ImagineResponse: Decodable {
    var error: Bool?
    var data: ImagineData?
}

struct ImagineData: Decodable {
    var requestId: String?
    var status: String?
    var error: String?
    var request: ImagineRequest?
    var result: [ImagineResult]?
}
struct ImagineResult: Decodable {
    var url: String?
}
struct ImagineRequest: Decodable {
    var profileId: Int?
    var app: String?
    var version: String?
    var userPrompt: String?
    var productionPrompt: String?
    var ai: String?
}

/*
 
 {
     "error": false,
     "data": {
         "requestId": "8b0e3314-c7b7-42d2-b109-74e3798e40cd",
         "status": "complete",
         "error": null,
         "result": [
             {
                 "id": "50d27de4-0ced-4693-baa2-4a9b89a5761d",
                 "url": "https://cdn.apiframe.pro/images/14261198400910553044113295127110-1.png"
             },
             {
                 "id": "346d16dd-ce72-4d18-9d7f-8a0806e0f39b",
                 "url": "https://cdn.apiframe.pro/images/14261198400910553044113295127110-2.png"
             },
             {
                 "id": "64abccb7-32ba-4982-9fa5-cccc11593909",
                 "url": "https://cdn.apiframe.pro/images/14261198400910553044113295127110-3.png"
             },
             {
                 "id": "4bb610a3-abe6-4410-8f91-c36c234b7b52",
                 "url": "https://cdn.apiframe.pro/images/14261198400910553044113295127110-4.png"
             }
         ],
         "request": {
             "profileId": 5,
             "app": "ai",
             "version": "1.0",
             "userPrompt": "sun",
             "productionPrompt": "sun",
             "ai": "apiframe"
         }
     }
 }
 
 */
struct FetchResponse: Decodable, Hashable {
    var error: Bool?
    var data: FetchData?
}
struct FetchData: Decodable, Hashable {
    var requestId: String?
    var status: String?
    var error: String?
    var result: [FetchDataResult]?
    var request: FetchDataRequest?
}
struct FetchDataResult: Identifiable, Decodable, Hashable {
    var id: String?
    var url: String?
}
struct FetchDataRequest: Decodable, Hashable {
    var profileId: Int?
    var app: String?
    var version: String?
    var userPrompt: String?
    var productionPrompt: String?
    var ai: String?
}



struct FavoritesResponse: Decodable, Hashable {
   var error: Bool?
    var data: [FetchDataResult]?
}

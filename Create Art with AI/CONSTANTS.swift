//
//  CONSTANTS.swift
//  AI-generator
//
//  Created by Руслан Каприор on 23.09.2024.
//

import Foundation
import SwiftUI

struct CONSTANTS {
    static let API_BASE_URL = "https://gamedevnexus.fun"
    static let PROFILE_ID = "5"
    static let LANGUAGE = "en"
    static let USER_ID: String = UIDevice.current.identifierForVendor!.uuidString
    static let MOCKED_IMAGES: [FetchDataResult] = [
        FetchDataResult(id: "a6bc6f87-3b6c-4407-856d-513a68a6a927", url: "https://cdn.apiframe.pro/images/31163383913893365614255687448879-1.png"),
        FetchDataResult(id: "2bea77ba-163c-42e1-8961-7db5f12c979a", url: "https://cdn.apiframe.pro/images/31163383913893365614255687448879-2.png"),
        FetchDataResult(id: "8fcab086-8953-4fa2-bf28-be4b69e82bbd", url: "https://cdn.apiframe.pro/images/31163383913893365614255687448879-3.png"),
        FetchDataResult(id: "87cdf578-1926-4a37-8884-612393e62a8c", url: "https://cdn.apiframe.pro/images/31163383913893365614255687448879-4.png")
    ]
}

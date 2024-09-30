//
//  OnboardingModels.swift
//  AI-generator
//
//  Created by Руслан Каприор on 18.09.2024.
//

import SwiftUI


struct OnboardingData: Identifiable, Hashable {
    var id: Int
    var title: String
    var description: String
    var image: String
    
    var background: Image { // calculable property not used by hashing
       Image(image)
    }
    
    init(id: Int, title:String, description: String, image: String) {
        self.id = id
        self.title = title
        self.description = description
        self.image = image
    }
    
    static func getDefaultMockData() -> [OnboardingData] {
        [
            OnboardingData(
                id: 0,
                title: "Bring Your Ideas to Life with AI!",
                description: "Describe any concept, and let our AI generate a custom image for you in no time. Creativity is just a few words away!",
                image: "onboardingImage01"
            ),
            OnboardingData(
                id: 1,
                title: "Explore a World of AI Creations!",
                description: "Dive into a collection of images generated by users from all over. Get inspired and see what's possible with AI.",
                image: "onboardingImage02"
            ),
            OnboardingData(
                id: 2,
                title: "Your Opinion Matters to Us!",
                description: "We’d love to hear from you! Share your feedback and help us make the app even better.",
                image: "onboardingImage03"
            ),
            OnboardingData(
                id: 3,
                title: "Stay Updated with the Latest Features!",
                description: "Turn on notifications for updates and tips",
                image: "onboardingImage04"
            )
        ]
    }
}


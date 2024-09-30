//
//  PaywallModels.swift
//  AI-generator
//
//  Created by Руслан Каприор on 18.09.2024.
//

import Foundation


struct PaywallRadioButtonItem: Equatable, Hashable {
    let title: String
    let subtitle: String
    let price: String
    var isBestOffer: Bool = false
}

//
//  File.swift
//  
//
//  Created by william Vise on 24/3/2023.
//

import Foundation


struct HomePageContent: Encodable {
    let title: String
    let subtitle: String
    let body: String
}

enum CorePage {
    case about
    case privacy
    case user
}

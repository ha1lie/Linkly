//
//  ZoomLinkColor.swift
//  Linkly
//
//  Created by Hallie on 9/12/21.
//

import SwiftUI
import Foundation

struct ZoomLinkColor: Codable, Hashable {
    
    private let colorName: String
    
    static let blue = ZoomLinkColor(colorName: "blue")
    static let green = ZoomLinkColor(colorName: "green")
    static let yellow = ZoomLinkColor(colorName: "yellow")
    static let orange = ZoomLinkColor(colorName: "orange")
    static let purple = ZoomLinkColor(colorName: "purple")
    static let pink = ZoomLinkColor(colorName: "pink")
    static let red = ZoomLinkColor(colorName: "red")
    static let black = ZoomLinkColor(colorName: "black")
    static let gray = ZoomLinkColor(colorName: "gray")
    static let none = ZoomLinkColor(colorName: "none")
    
    func getColor() -> Color {
        switch self.colorName {
        case "blue":
            return .blue
        case "green":
            return .green
        case "yellow":
            return .yellow
        case "orange":
            return .orange
        case "purple":
            return .purple
        case "pink":
            return .pink
        case "red":
            return .red
        case "black":
            return .black
        case "gray":
            return .gray
        case "none":
            return .blue //Should never be shown, just used for equality sakes
        default:
            return .blue
        }
    }
}

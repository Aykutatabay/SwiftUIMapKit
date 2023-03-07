//
//  Model.swift
//  SwiftUIMapKit
//
//  Created by Aykut ATABAY on 22.02.2023.
//

import Foundation
import CoreLocation
struct UberLocation: Identifiable {
    var id: UUID = UUID()
    let title: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
}

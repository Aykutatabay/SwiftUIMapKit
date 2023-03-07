//
//  MapViewModel.swift
//  SwiftUIMapKit
//
//  Created by Aykut ATABAY on 21.02.2023.
//

import Foundation
import CoreLocation
import MapKit
import Combine

@MainActor class MapViewModel:NSObject, ObservableObject {
    
    let userLocationManager: UserLocationManager = UserLocationManager()
    var cancellables = Set<AnyCancellable>()
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 38.423733, longitude: 27.142826),span: MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25))
    
    func getuserLocationCoordinate() {
        userLocationManager.$userLocationCoordinate
            .sink { [weak self] userLocationCoordinate in
                self?.region = MKCoordinateRegion(center: userLocationCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25))
                print("DEBUG::::")
                
            }
            .store(in: &cancellables)
    }
}

enum MapViewState {
    case noInput
    case locationSelected
    case searchingForLocation
}

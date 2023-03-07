//
//  UserLocationManager.swift
//  SwiftUIMapKit
//
//  Created by Aykut ATABAY on 21.02.2023.
//

import CoreLocation
import MapKit
import Combine

class UserLocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var userLocationCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 38.423733, longitude: 27.142826)
    var locationManager: CLLocationManager?
    var cancellables = Set<AnyCancellable>()
    
    func checkLocationServicesIsEnabled() {
        DispatchQueue.main.async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager = CLLocationManager()
                self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest
                // when autohrization changes cllocationmanagerobject will created
                self.locationManager?.delegate = self
                print("Aykut")
            } else {
                print("Return turn it on")
            }
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            print("Your location is denied")
        case .authorizedWhenInUse, .authorizedAlways:
            sinkUserLocation()
        case .restricted:
            print("Your location is restricted")
        @unknown default:
            break
        }
    }
    
    func shareUserlocation() -> AnyPublisher<CLLocationCoordinate2D, Error> {
        Future<CLLocationCoordinate2D, Error> { promise in
            if let locationManager = self.locationManager {
                promise(.success(locationManager.location?.coordinate ?? CLLocationCoordinate2D(latitude: 38.423733, longitude: 27.142826)))
            } else {
                let error = URLError(.badURL)
                promise(.failure(CustomError.init()))
            }
        }.eraseToAnyPublisher()
    }
    
    func sinkUserLocation() {
        shareUserlocation()
            .sink { completion in
                switch completion {
                case .finished:
                    print("Succesfully get userLocationCoordinate")
                case .failure(let error):
                    print(error.localizedDescription,"DEBUG:::")
                }
            } receiveValue: { coordinate in
                self.userLocationCoordinate = coordinate
            }
            .store(in: &cancellables)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}

struct CustomError: Error  {
    
}

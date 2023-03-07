//
//  LocationSearchViewModel.swift
//  SwiftUIMapKit
//
//  Created by Aykut ATABAY on 22.02.2023.
//

import Foundation
import MapKit
import Combine


class LocationSearchViewModel: NSObject, ObservableObject {
    let locationManager = UserLocationManager()
    @Published var annotationItems: [UberLocation] = []
    @Published var results: [MKLocalSearchCompletion] = []
    var cancellables = Set<AnyCancellable>()
    var queryFragment: String = "" {
        didSet {
            searchCompleter.queryFragment = queryFragment
        }
    }
    
    let searchCompleter = MKLocalSearchCompleter()
    
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }
    
    
    func publishedSelectedLocation(_ localSearch: MKLocalSearchCompletion) {
        selectLocation(localSearch)
            .sink(receiveCompletion: { _ in
            }, receiveValue: { selectedLocation in
                if !self.annotationItems.isEmpty {
                    self.annotationItems.remove(at: 0)
                }
                self.annotationItems.append(selectedLocation)
            })
            .store(in: &cancellables)
    }

    func selectLocation(_ localSearch: MKLocalSearchCompletion) -> AnyPublisher<UberLocation, Error> {
        print("Location geldi")
        return Future<UberLocation, Error> { promise in
            self.locationSearch(forLocalSearchCompletion: localSearch) { response, error in
                if let error = error {
                    promise(.failure(error))
                    print("ERROR: ",error.localizedDescription)
                }
                guard let item = response?.mapItems.first else { return }
                let coordinate = item.placemark.coordinate
                guard let title = item.placemark.title else { return }
                
                let location = UberLocation(title: title, coordinate: coordinate)
                promise(.success(location))
                
            }

                    
        }.eraseToAnyPublisher()
    }
    
    
    func locationSearch(forLocalSearchCompletion localSearch: MKLocalSearchCompletion, completion: @escaping MKLocalSearch.CompletionHandler)  {
        print("Location geldi 2")
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        
        let search = MKLocalSearch(request: searchRequest)
        search.start(completionHandler: completion)
    }
}

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}

//
//  ContentView.swift
//  SwiftUIMapKit
//
//  Created by Aykut ATABAY on 21.02.2023.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @EnvironmentObject var locationSearchVM: LocationSearchViewModel
    @State var mapState: MapViewState = MapViewState.noInput
    @StateObject private var viewModel: MapViewModel = MapViewModel()
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 38.423733, longitude: 27.142826),span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    var body: some View {
        ZStack(alignment: .topLeading) {   
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: locationSearchVM.annotationItems, annotationContent: { content in
                MapMarker(coordinate: content.coordinate, tint: .mint)
                
            })
                .ignoresSafeArea()
                .accentColor(.pink)
            
            
            if mapState == .noInput || mapState == .locationSelected {
                HStack {
                    
                    LocationSearchActivationView(mapState: $mapState)
                        .padding(.top, 70)
                        .padding(.leading, 30)
                    
                }
            } else if mapState == .searchingForLocation {
                LocationSelectionView(mapState: $mapState)
            }
            
            MapActionButton(mapState: $mapState)
                .padding(.leading)
                .padding(.top)
        }
        .onAppear {
            viewModel.userLocationManager.checkLocationServicesIsEnabled()
            viewModel.getuserLocationCoordinate()
        }
    }
}

 struct ContentView_Previews: PreviewProvider {
     static var previews: some View {
         ContentView()
     }
 }
 


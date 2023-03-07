//
//  LocationSelectionView.swift
//  SwiftUIMapKit
//
//  Created by Aykut ATABAY on 22.02.2023.
//

import SwiftUI

struct LocationSelectionView: View {
    @EnvironmentObject var locationSearchVM: LocationSearchViewModel
    @Binding var mapState: MapViewState
    @State private var startLocationText: String = "Narlidere"
    @StateObject var mapVM: MapViewModel = MapViewModel()
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 8, height: 8)
                    
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1, height: 24)
                    
                    Rectangle()
                        .fill(Color(.black))
                        .frame(width: 8, height: 8)
                }
                
                VStack {
                    TextField("Current Location", text: $startLocationText)
                        .frame(height: 40)
                        .background(Color(.black).opacity(0.5))
                        .padding(.trailing)
                    
                    TextField(" Where to?", text: $locationSearchVM.queryFragment)
                        .frame(height: 40)
                        .background(Color(.systemGray4))
                        .padding(.trailing)
                }
            }
            .padding(.horizontal)
            .padding(.top , 64)
            Divider()
                .padding(.vertical)
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(locationSearchVM.results, id: \.self) { result in
                        LocationResultCell(title: result.title, subTitle: result.subtitle)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    print("xxxxx",result)
                                    locationSearchVM.publishedSelectedLocation(result)
                                    mapState = .locationSelected
                                }
                            }
                    }
                }
            }
        }
        .background(Color.black)
    }
}

struct LocationSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSelectionView(mapState: .constant(.locationSelected))
    }
}

//
//  MapActionButton.swift
//  SwiftUIMapKit
//
//  Created by Aykut ATABAY on 21.02.2023.
//

import SwiftUI

struct MapActionButton: View {
    @Binding var mapState: MapViewState
    var body: some View {
        Button {
            
        } label: {
            Image(systemName: mapState == .searchingForLocation ? "arrow.left" : "line.3.horizontal")
                .font(.title)
                .foregroundColor(.black)
                .background {
                    Circle()
                        .frame(width: 45, height: 45)
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 5)
                }
        }
    }
}

struct MapActionButton_Previews: PreviewProvider {
    static var previews: some View {
        MapActionButton(mapState: .constant(.locationSelected))
    }
}

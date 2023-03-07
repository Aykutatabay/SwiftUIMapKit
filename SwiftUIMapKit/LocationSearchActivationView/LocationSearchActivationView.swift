//
//  LocationSearchActivationView.swift
//  SwiftUIMapKit
//
//  Created by Aykut ATABAY on 21.02.2023.
//

import SwiftUI

struct LocationSearchActivationView: View {
    @Binding var mapState: MapViewState
    var body: some View {
        Button {
            mapState = .searchingForLocation
        } label: {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: UIScreen.main.bounds.width - 64, height: 50)
                .foregroundColor(.white)
                .shadow( color: .black, radius: 5)
                .overlay {
                    HStack {
                        Rectangle()
                            .frame(width: 8, height: 8)
                            .foregroundColor(.black)
                        Text("Where to ?")
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    .padding()
                }
        }

    }
}

struct LocationSearchActivationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchActivationView(mapState: .constant(.searchingForLocation))
    }
}

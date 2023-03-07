//
//  LocationResultCell.swift
//  SwiftUIMapKit
//
//  Created by Aykut ATABAY on 22.02.2023.
//

import SwiftUI

struct LocationResultCell: View {
    let title: String
    let subTitle: String
    var body: some View {
        HStack {
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .foregroundColor(.blue)
                .accentColor(.white)
                .frame(width: 30, height: 30)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.body)
                    .bold()
                Text(subTitle)
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
                
                Rectangle()
                    .frame(width: 300, height: 0.3)
            }
            .padding(.leading, 8)
            .padding(.vertical, 8)
            

        }
        .padding(.leading)
    }
}

struct LocationResultCell_Previews: PreviewProvider {
    static var previews: some View {
        LocationResultCell(title: "Sturbucks", subTitle: "Narlidere Izmir")
    }
}

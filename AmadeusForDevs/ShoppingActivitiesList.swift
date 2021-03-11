//
//  ShoppingActivitiesList.swift
//  AmadeusForDevs
//
//  Created by Daniel Ayala on 10/3/21.
//

import Foundation
import SwiftUI

struct ShoppingActivitiesList: View {
    @ObservedObject var locationManager = LocationManager()
    
    var cityName: String {
        return"\(locationManager.locationPlace?.locality ?? "")"
    }
    
    var activities: [ShoppingSingleActivity] {
        return locationManager.activities ?? [ShoppingSingleActivity]()
    }

    var body: some View {
        NavigationView {
            List(activities) { activity in
                ShoppingActivityRow(shoppingSingleActivity: activity)
//                NavigationLink(destination: LandmarkDetail(landmark: landmark)) {
//                }
            }
            .navigationTitle("Experiences in \(cityName)")
        }
    }
}

struct ShoppingActivitiesList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE (2nd generation)", "iPhone XS Max"], id: \.self) { deviceName in
            ShoppingActivitiesList()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}

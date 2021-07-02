//
//  ContentView.swift
//  AmadeusForDevs
//
//  Created by Daniel Ayala on 10/3/21.
//

import SwiftUI


struct ContentView: View {
    @ObservedObject var locationManager = LocationManager()
    
    var userLatitude: String {
        return "\(locationManager.lastLocation?.coordinate.latitude ?? 0)"
    }
    
    var userLongitude: String {
        return "\(locationManager.lastLocation?.coordinate.longitude ?? 0)"
    }
    
    var cityName: String {
        return"\(locationManager.locationPlace?.locality ?? "")"
    }
    
    
    var body: some View {
        VStack {
//            Text("location status: \(locationManager.statusString)")
//            HStack {
//                Text("latitude: \(userLatitude)")
//                Text("longitude: \(userLongitude)")
//            }
            ShoppingActivitiesList()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ShoppingActivityWidgetView.swift
//  AmadeusForDevs
//
//  Created by Daniel Ayala on 12/3/21.
//

import SwiftUI
import WidgetKit

struct RemoteImage: View {
    private enum LoadState {
        case loading, success, failure
    }
    
    private class Loader: ObservableObject {
        var data = Data()
        var state = LoadState.loading
        
        init(url: String) {
            guard let parsedURL = URL(string: url) else {
                fatalError("Invalid URL: \(url)")
            }
            
            URLSession.shared.dataTask(with: parsedURL) { data, response, error in
                if let data = data, data.count > 0 {
                    self.data = data
                    self.state = .success
                } else {
                    self.state = .failure
                }
                
                DispatchQueue.main.async {
                    self.objectWillChange.send()
                }
            }.resume()
        }
    }
    
    @StateObject private var loader: Loader
    var loading: Image
    var failure: Image
    
    var body: some View {
        selectImage()
            .resizable()
    }
    
    init(url: String, loading: Image = Image(systemName: "photo"), failure: Image = Image(systemName: "multiply.circle")) {
        _loader = StateObject(wrappedValue: Loader(url: url))
        self.loading = loading
        self.failure = failure
    }
    
    private func selectImage() -> Image {
        switch loader.state {
        case .loading:
            return loading
        case .failure:
            return failure
        default:
            if let image = UIImage(data: loader.data) {
                return Image(uiImage: image)
            } else {
                return failure
            }
        }
    }
}

struct ShoppingActivityWidgetData {
    let name: String
    let picture: String
    let shortDescription: String? = nil
    let rating: String? = nil
    let price: String
}

extension ShoppingActivityWidgetData {
    static let previewData = ShoppingActivityWidgetData(name: "Skip-the-line tickets to the Reina Sofía Museum", picture: "https://images.musement.com/default/0001/25/madrid-reina-sofia-museum-tickets_header-24162.jpeg?w=500", price: "10.00 Eur")
}

struct ShoppingActivityWidgetView: View {
    
    let data: ShoppingActivityWidgetData
    @Environment(\.widgetFamily) var widgetFamily
    
    var body: some View {
        ZStack {
            Color(.darkGray)
            
            HStack {
                VStack(alignment: .leading) {
                    ShoppingActivityNameView(data: data)
                }
                .padding(.all)
                
                if widgetFamily == .systemMedium || widgetFamily == .systemLarge,
                   let photoName = data.picture {
                    RemoteImage(url: photoName)
                }
            }
            
        }
        
    }
}

struct ShoppingActivityNameView: View {
    let data: ShoppingActivityWidgetData
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(data.name)
                    .font(.body)
                    .foregroundColor(Color(.white))
                    .bold()
                
                
                
                Spacer()
                
                Text(data.price)
                    .font(.caption)
                    .bold()
                    .foregroundColor(Color(.white))
                    .minimumScaleFactor(0.8)
            }
            Spacer(minLength: 0)
        }
        .padding(.all, 8.0)
        .background(ContainerRelativeShape().fill(Color(.gray)))
    }
}

struct ShoppingActivityWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            
            ShoppingActivityWidgetView(data: .previewData)
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            
            ShoppingActivityWidgetView(data: .previewData)
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            
            ShoppingActivityWidgetView(data: .previewData)
                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
        
    }
}

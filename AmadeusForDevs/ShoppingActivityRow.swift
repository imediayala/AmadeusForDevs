//
//  ShoppingActivityRow.swift
//  AmadeusForDevs
//
//  Created by Daniel Ayala on 10/3/21.
//

import SwiftUI

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

struct ShoppingActivityRow: View {
    var shoppingSingleActivity: ShoppingSingleActivity

    var body: some View {
        ZStack {
            VStack {
                RemoteImage(url: shoppingSingleActivity.pictures?.first ?? "https://images.musement.com/default/0001/25/madrid-reina-sofia-museum-tickets_header-24162.jpeg?w=500")
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300)
                    .padding()

                Text( shoppingSingleActivity.name ?? "")
                    .scaledToFit()
                    .font(.title)
                
                Text( shoppingSingleActivity.shortDescription ?? "")
                    .padding()
                    .font(.title3)

                Spacer()
            }
        }
    }
}

struct ShoppingActivityRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ShoppingActivityRow(shoppingSingleActivity: activities[0] )
            ShoppingActivityRow(shoppingSingleActivity: activities[1])
        }
        .previewLayout(.fixed(width: 500, height: 300))
    }
}


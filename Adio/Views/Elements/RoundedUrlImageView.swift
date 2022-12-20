//
//  RoundedUrlImageView.swift
//  Adio
//
//  Created by Alex Loren on 12/19/22.
//

import SwiftUI

struct RoundedUrlImageView: View {
    // MARK: - Properties
    @State private var image: UIImage?
    private var width: CGFloat
    private var height: CGFloat
    private var shadowRadius: CGFloat
    private let url: URL
    
    // MARK: - View declaration.
    var body: some View {
        if let image {
            Image(uiImage: image)
                .resizable()
                .frame(width: width, height: height)
                .cornerRadius(8)
                .shadow(color: image.averageColor ?? .black, radius: shadowRadius)
                .transition(.scale.animation(.spring()))
        } else {
            Text("Loading..")
                .foregroundColor(.text)
                .font(.subheadline)
                .task {
                    guard image == nil else {
                        return
                    }
                    image = await fetchImage(from: url)
                }
        }
    }
    
    // MARK: - Functions
    /// Configures the view parameters before being displayed.
    /// - Parameters:
    ///   - url: The `URL` where the image can be found.
    ///   - width: Frame width of the image.
    ///   - height: Frame height of the image.
    init(from url: URL, width: CGFloat = 250, height: CGFloat = 250, shadowRadius: CGFloat = 8) {
        self.width = width
        self.height = height
        self.shadowRadius = shadowRadius
        self.url = url
    }
    
    /// Attempts to fetch an image from a remote source.
    /// - Parameter url: Where should the image be fetched from?
    /// - Returns: An option `UIImage`.
    func fetchImage(from url: URL) async -> UIImage? {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return UIImage(data: data)
        } catch {
            print("Could not fetch image from remote server, error of: \(error.localizedDescription)")
            return nil
        }
    }
}

struct RoundedUrlImageView_Previews: PreviewProvider {
    // MARK: - View declaration.
    static var previews: some View {
        RoundedUrlImageView(from: URL(string: "https://picsum.photos/250")!)
    }
}

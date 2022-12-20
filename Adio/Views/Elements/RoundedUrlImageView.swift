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
    
    @EnvironmentObject var socketClient: SocketClient
    
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
                    image = await socketClient.fetchImage(from: url)
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
}

struct RoundedUrlImageView_Previews: PreviewProvider {
    // MARK: - Properties.
    static let socketClient = SocketClient()
    
    // MARK: - View declaration.
    static var previews: some View {
        RoundedUrlImageView(from: URL(string: "https://picsum.photos/250")!)
            .environmentObject(socketClient)
    }
}

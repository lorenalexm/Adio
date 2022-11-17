//
//  Image+AverageColor.swift
//  Adio
//
//  Created by Alex Loren on 11/17/22.
//

import UIKit
import SwiftUI

extension UIImage {
    var averageColor: Color? {
        guard let input = CIImage(image: self) else {
            return nil
        }
        
        let extentVector = CIVector(x: input.extent.origin.x, y: input.extent.origin.y, z: input.extent.size.width, w: input.extent.size.height)
        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: input, kCIInputExtentKey: extentVector]),
              let output = filter.outputImage else {
            return nil
        }
        
        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull!])
        context.render(output, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)
        
        return Color(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255)
    }
}

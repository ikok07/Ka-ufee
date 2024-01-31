//
//  ImageMethods.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 30.01.24.
//

import UIKit

struct Images {
    
    static func getFixedImage(from uiImage: UIImage?) -> UIImage? {
        
        guard let uiImage else {
            return nil
        }
        
        guard uiImage.imageOrientation != UIImage.Orientation.up else {
            // This is default orientation, don't need to do anything
            return uiImage.copy() as? UIImage
        }
        
        guard let cgImage = uiImage.cgImage else {
            // CGImage is not available
            return nil
        }
        
        guard let colorSpace = cgImage.colorSpace, let ctx = CGContext(data: nil, width: Int(uiImage.size.width), height: Int(uiImage.size.height), bitsPerComponent: cgImage.bitsPerComponent, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) else {
            return nil // Not able to create CGContext
        }
        
        var transform: CGAffineTransform = CGAffineTransform.identity
        
        switch uiImage.imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: uiImage.size.width, y: uiImage.size.height)
            transform = transform.rotated(by: CGFloat.pi)
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: uiImage.size.width, y: 0)
            transform = transform.rotated(by: CGFloat.pi / 2.0)
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: uiImage.size.height)
            transform = transform.rotated(by: CGFloat.pi / -2.0)
        case .up, .upMirrored:
            break
        @unknown default:
            break
        }
        
        // Flip image one more time if needed to, this is to prevent flipped image
        switch uiImage.imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: uiImage.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: uiImage.size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .up, .down, .left, .right:
            break
        @unknown default:
            break
        }
        
        ctx.concatenate(transform)
        
        switch uiImage.imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: uiImage.size.height, height: uiImage.size.width))
        default:
            ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: uiImage.size.width, height: uiImage.size.height))
            break
        }
        
        guard let newCGImage = ctx.makeImage() else { return nil }
        return UIImage.init(cgImage: newCGImage, scale: 1, orientation: .up)
    }
    
}

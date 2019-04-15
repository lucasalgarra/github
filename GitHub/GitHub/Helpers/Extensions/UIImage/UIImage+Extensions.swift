//
//  UIImage+Extensions.swift
//  GitHub
//
//  Created by Lucas Algarra on 15/04/19.
//  Copyright © 2019 João Lucas Algarra. All rights reserved.
//

import UIKit

//-----------------------------------------------------------------------------
// MARK: - Download
//-----------------------------------------------------------------------------

extension UIImage {
    
    static let imagesFolder = "images"
    
    static func clearCachedImages() {
        guard let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else { return }
        let imageFolderPath = documentsPath + "/\(imagesFolder)"
        try? FileManager.default.removeItem(atPath: imageFolderPath)
    }
    
    static func download(imageWithURL imageUrl: URL, completion: @escaping (_ image: UIImage?, _ imageUrl: URL) -> Void) {
        
        guard let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
            completion(nil, imageUrl)
            return
        }
        
        let paths = imageUrl.pathComponents
        var imageName = paths.joined(separator: "_")
        imageName = imageName.replacingOccurrences(of: ".", with: "_")
        imageName = imageName.replacingOccurrences(of: "/", with: "")
        
        let imageFolderPath = documentsPath + "/\(imagesFolder)"
        
        var imagePath = imageFolderPath + "/\(imageName)"
        
        if let folder = imageUrl.host {
            let folderPath = imageFolderPath + "/\(folder)"
            if !FileManager.default.fileExists(atPath: folderPath) {
                try? FileManager.default.createDirectory(atPath: folderPath, withIntermediateDirectories: true, attributes: nil)
            }
            imagePath = folderPath + "/\(imageName)"
        }
        
        let imagePathURL = URL(fileURLWithPath: imagePath)
        
        if FileManager.default.fileExists(atPath: imagePath),
            let imageData: Data = try? Data(contentsOf: imagePathURL),
            let image: UIImage = UIImage(data: imageData, scale: UIScreen.main.scale) {
            
            completion(image, imageUrl)
            return
        }
        
        DispatchQueue.global(qos: .background).async {
            
            if let imageData: Data = try? Data(contentsOf: imageUrl),
                let image: UIImage = UIImage(data: imageData, scale: UIScreen.main.scale) {
                
                DispatchQueue.main.async {
                    do {
                        try image.pngData()?.write(to: imagePathURL)
                    } catch {
                        debugPrint(error)
                    }
                    completion(image, imageUrl)
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(nil, imageUrl)
            }
        }
        
    }
    
}

//-----------------------------------------------------------------------------
// MARK: - Color
//-----------------------------------------------------------------------------

extension UIImage {
    
    public func maskImage(with color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        if let context: CGContext = UIGraphicsGetCurrentContext() {
            context.translateBy(x: 0, y: self.size.height)
            context.scaleBy(x: 1.0, y: -1.0)
            
            context.setBlendMode(.normal)
            let rect: CGRect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
            
            let colors: [CGColor] = [color.cgColor, color.cgColor]
            
            let colorsCFArray = colors as CFArray
            
            let space = CGColorSpaceCreateDeviceRGB()
            if let gradient: CGGradient = CGGradient(colorsSpace: space, colors: colorsCFArray, locations: nil) {
                context.clip(to: rect, mask: self.cgImage!)
                context.drawLinearGradient(
                    gradient,
                    start: CGPoint(x: 0, y: 0),
                    end: CGPoint(x: 0, y: self.size.height),
                    options: .drawsAfterEndLocation)
                let coloredImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                return coloredImage!
            }
        }
        
        return self
    }
    
}

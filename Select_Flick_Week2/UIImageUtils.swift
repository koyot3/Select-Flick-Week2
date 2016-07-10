//
//  UIImageUtils.swift
//  Select_Flick_Week2
//
//  Created by admin on 7/10/16.
//  Copyright © 2016 koyot3. All rights reserved.
//

import UIKit

struct UIImageUtils {
    static func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        image.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
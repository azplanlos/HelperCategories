//
//  SIGeometry.m
//  Photoroute
//
//  Created by Andreas Zöllner on 25.01.15.
//  Copyright (c) 2015 Studio Istanbul Medya Hiz. Tic. Ltd. Sti. All rights reserved.
//

#import "SIGeometry.h"

CGFloat scaleFactorForScaleFromRectToRect(NSRect rect1, NSRect rect2) {
    return scaleFactorForScaleFromSizeToSize(rect1.size, rect2.size);
}

CGFloat scaleFactorForScaleFromSizeToSize(NSSize size1, NSSize size2) {
    CGFloat boundingBoxAspectRatio = size1.width/size1.height;
    CGFloat viewAspectRatio = size2.width/size2.height;
    
    CGFloat scaleFactor = 1.0;
    if (boundingBoxAspectRatio > viewAspectRatio) {
        // Width is limiting factor
        scaleFactor = size2.width/size1.width;
    } else {
        // Height is limiting factor
        scaleFactor = size2.height/size1.height;
    }
    return scaleFactor;
}

NSRect NSRectScaleByFactor(NSRect rect, CGFloat scaleFactor) {
    return NSMakeRect(rect.origin.x * scaleFactor, rect.origin.y * scaleFactor, rect.size.width * scaleFactor, rect.size.height * scaleFactor);
}

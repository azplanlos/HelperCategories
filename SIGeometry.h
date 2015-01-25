//
//  SIGeometry.h
//  Photoroute
//
//  Created by Andreas Zöllner on 25.01.15.
//  Copyright (c) 2015 Studio Istanbul Medya Hiz. Tic. Ltd. Sti. All rights reserved.
//

#import <Foundation/Foundation.h>

CGFloat scaleFactorForScaleFromRectToRect(NSRect rect1, NSRect rect2);
CGFloat scaleFactorForScaleFromSizeToSize(NSSize size1, NSSize size2);
NSRect NSRectScaleByFactor(NSRect rect, CGFloat scaleFactor);
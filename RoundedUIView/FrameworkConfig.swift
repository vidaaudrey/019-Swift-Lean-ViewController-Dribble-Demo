//
//  AppConfig.swift
//  017-Beautiful-ID-Photo
//
//  Created by Audrey Li on 4/18/15.
//  Copyright (c) 2015 shomigo.com. All rights reserved.
//

import Foundation
import UIKit

public struct FrameworkConstants {
    public static let printTitleFont =  UIFont (name: "HelveticaNeue-Bold", size: 20)
    public  static let cuttingBorderColor = UIColor.grayColor()
    
    // for CirCular-Control
    public static let circularSliderSize: CGFloat = UIScreen.mainScreen().bounds.size.width
    public static let circularSliderPadding: CGFloat = 60
    public static let circularSliderLineWidth: CGFloat = 250
    public static let circularSliderFontSize: CGFloat = 40
    
    // for currency converter
    public static let currencyAPIURLPrefix = "http://api.fixer.io/latest?symbols="
    public static let currencyAPIBaseURLPrefix = "http://api.fixer.io/latest?base="
    
    public static let DRIBBLE_ACCESS_TOKEN = "01fc9f4f4195073f4f2a340df4bef928c9d5ad277fe8e27c47daa96bf75419a0"
    public static let DRIBBLE_SHOT_URL = "https://api.dribbble.com/v1/shots"
    public static let TEST_URL = "http://www.telize.com/geoip"
    
}


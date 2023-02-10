//
//  Utils.swift
//  opencv-test-main
//
//  Created by 孔繁臻 on 2/10/23.
//

import Foundation
import UIKit

func allFont() {
    //遍历所有字体，这时已经把新字体添加进去了
    for fontfamilyname in UIFont.familyNames {
        print("family:'\(fontfamilyname)'")
        for fontName in UIFont.fontNames(forFamilyName: fontfamilyname) {
            print("\tfont:'\(fontName)'")
        }
        print("-------------")
    }
}
    

//
//  Backend.swift
//  opencv-test-main
//
//  Created by 孔繁臻 on 1/31/23.
//

import UIKit
import Amplify
 
class Backend {
    static let shared = Backend()
    static func initialize() -> Backend {
        return .shared
    }
    private init() {
      // initialize amplify
      do {
        try Amplify.configure()
        print("Initialized Amplify");
      } catch {
        print("Could not initialize Amplify: \(error)")
      }
    }
}

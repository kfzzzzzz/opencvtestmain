//
//  stableDiffusionTestController.swift
//  opencv-test-main
//
//  Created by 孔繁臻 on 3/31/23.
//

import Foundation
import UIKit

class stableDiffusionManager : NSObject {
    
    static let shared = stableDiffusionManager()
    
    override init() {
        super.init()
    }
    
    func testRequest(){
        
        // 1. 创建 URL 对象
        guard let url = URL(string: "https://webui-debug.site.youdao.com/robots.txt") else {
            print("Invalid URL")
            return
        }

        // 2. 创建请求对象，并设置 HTTP 头信息
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        // 3. 创建 URL 会话并发送请求
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            // 处理响应
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response")
                return
            }
            
            guard let data = data,
                  let text = String(data: data, encoding: .utf8) else {
                print("Invalid response data")
                return
            }
            
            print("Response Text: \(text)")
        }

        task.resume()
        
    }
    
}

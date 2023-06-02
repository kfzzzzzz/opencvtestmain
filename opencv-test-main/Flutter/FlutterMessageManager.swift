//
//  FlutterMessageManager.swift
//  opencv-test-main
//
//  Created by 孔繁臻 on 4/11/23.
//

import Foundation
import Flutter

class FlutterMessageManager : NSObject {
    
    var engine : FlutterEngine?
    
    static let shared = FlutterMessageManager()
    
    func handleMessage(){
        let MessgaeChannel = FlutterMethodChannel(name: "xinTai/MethodChannel",
                                                  binaryMessenger: engine!.binaryMessenger)
        MessgaeChannel.setMethodCallHandler({
          [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
          // This method is invoked on the UI thread.
          guard call.method == "getBatteryLevel" else {
            result(FlutterMethodNotImplemented)
            return
          }
            self?.receiveBatteryLevel(result: result)
        })
        MessgaeChannel.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            // This method is invoked on the UI thread.
            guard call.method == "getGPTKey" else {
              result(FlutterMethodNotImplemented)
              return
            }
            self?.getGPTKey(result: result)
          })
    }
    
    private func receiveBatteryLevel(result: FlutterResult) {
      let device = UIDevice.current
      device.isBatteryMonitoringEnabled = true
      if device.batteryState == UIDevice.BatteryState.unknown {
        result(FlutterError(code: "UNAVAILABLE",
                            message: "Battery level not available.",
                            details: nil))
      } else {
        result(Int(device.batteryLevel * 100))
      }
    }
    
    private func getGPTKey(result:  @escaping FlutterResult){
        AccountManager.shared.retrieveImage(name: "GPTKEY.txt") { output in
            switch output {
            case let .success(data):
                if let key = String(data: data, encoding: .utf8) {
                    result(key)
                } else {
                    result(FlutterError(code: "UNAVAILABLE",
                                        message: "获取GPTKey失败.",
                                        details: nil))
                }
            case .failure(_):
                result(FlutterError(code: "UNAVAILABLE",
                                    message: "获取GPTKey失败.",
                                    details: nil))
            }
        }
    }
}

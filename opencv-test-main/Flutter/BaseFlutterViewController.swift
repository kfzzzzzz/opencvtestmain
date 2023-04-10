//
//  BaseFlutterViewController.swift
//  opencv-test-main
//
//  Created by 孔繁臻 on 4/7/23.
//

import Flutter


class BaseFlutterViewController: FlutterViewController {
    
    //    let channelName = "com.example.flutter_app/page"
    //    let eventChannelName = "com.example.flutter_app/events"
    //    var eventSink: FlutterEventSink?
    
    let flutterEngine = (UIApplication.shared.delegate as! AppDelegate).flutterEngine
    
    
    
}
    
    
    
//    init() {
//
//        // 创建 Flutter 引擎对象
//        let flutterEngine = FlutterEngine(name: "my_engine")
//        flutterEngine.run()
//
//        // 将引擎对象设置为 ViewController 的引擎
//        super.init(engine: flutterEngine, nibName: nil, bundle: nil)
//
////        // 设置 Flutter 引擎参数
////        var runArgs = FlutterRunArguments()
////        runArgs.arguments = ["--dart-flags=--observe"]
////        flutterEngine.run(withEntrypoint: nil, initialRoute: nil, runArgs: runArgs)
//
//        // 初始化 MethodChannel
//        let methodChannel = FlutterMethodChannel(name: channelName, binaryMessenger: self.binaryMessenger)
//        methodChannel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
//            self?.handleMethodCall(call: call, result: result)
//        }
//
//        // 初始化 EventChannel
//        let eventChannel = FlutterEventChannel(name: eventChannelName, binaryMessenger: self.binaryMessenger)
//        eventChannel.setStreamHandler(self)
//    }
//
//    required init(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func handleMethodCall(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        // 子类可以覆盖此方法以处理来自 Flutter 的方法调用
//        result(FlutterMethodNotImplemented)
//    }
//}

//extension BaseFlutterViewController: FlutterStreamHandler {
//
//    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
//        // 记录 EventSink
//        self.eventSink = events
//        return nil
//    }
//
//    func onCancel(withArguments arguments: Any?) -> FlutterError? {
//        // 清空 EventSink
//        self.eventSink = nil
//        return nil
//    }
//}

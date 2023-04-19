// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "f6e7cb1c6515ac035f05ac43f19db21e"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: ChatRoom.self)
    ModelRegistry.register(modelType: Message.self)
    ModelRegistry.register(modelType: NewTestModel.self)
  }
}
// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "beece81e350b4131b540d28da5678b96"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: UserModel.self)
    ModelRegistry.register(modelType: ChatRoom.self)
    ModelRegistry.register(modelType: Message.self)
  }
}
// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "988ae61cfc29f27eb13d3f8ddc14ad75"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: UserTest.self)
    ModelRegistry.register(modelType: NewTestModel.self)
  }
}
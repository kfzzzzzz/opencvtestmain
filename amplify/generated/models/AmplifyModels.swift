// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "2428f91c42a44f6fdc553a6e006a0c7e"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: UserTest.self)
    ModelRegistry.register(modelType: NewTestModel.self)
    ModelRegistry.register(modelType: NoteData.self)
  }
}
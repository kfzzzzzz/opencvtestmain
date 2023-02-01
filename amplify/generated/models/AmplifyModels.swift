// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "19dbc4ac60a8ab1901b266610527af2c"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: NewTestModel.self)
    ModelRegistry.register(modelType: NoteData.self)
  }
}
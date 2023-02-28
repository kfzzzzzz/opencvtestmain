// swiftlint:disable all
import Amplify
import Foundation

extension NewTestModel {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case kfz_name
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let newTestModel = NewTestModel.keys
    
    model.authRules = [
      rule(allow: .private, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "NewTestModels"
    
    model.attributes(
      .primaryKey(fields: [newTestModel.id])
    )
    
    model.fields(
      .field(newTestModel.id, is: .required, ofType: .string),
      .field(newTestModel.kfz_name, is: .optional, ofType: .string),
      .field(newTestModel.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(newTestModel.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}

extension NewTestModel: ModelIdentifiable {
  public typealias IdentifierFormat = ModelIdentifierFormat.Default
  public typealias IdentifierProtocol = DefaultModelIdentifier<Self>
}
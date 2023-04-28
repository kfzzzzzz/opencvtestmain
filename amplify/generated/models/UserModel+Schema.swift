// swiftlint:disable all
import Amplify
import Foundation

extension UserModel {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case UserPhoneNumber
    case UserName
    case UserImage
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let userModel = UserModel.keys
    
    model.authRules = [
      rule(allow: .public, operations: [.create, .update, .delete, .read]),
      rule(allow: .public, provider: .iam, operations: [.create, .update, .delete, .read]),
      rule(allow: .owner, ownerField: "owner", identityClaim: "cognito:username", provider: .userPools, operations: [.create, .update, .delete, .read]),
      rule(allow: .private, operations: [.create, .update, .delete, .read]),
      rule(allow: .private, provider: .iam, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "UserModels"
    
    model.attributes(
      .primaryKey(fields: [userModel.id])
    )
    
    model.fields(
      .field(userModel.id, is: .required, ofType: .string),
      .field(userModel.UserPhoneNumber, is: .required, ofType: .string),
      .field(userModel.UserName, is: .required, ofType: .string),
      .field(userModel.UserImage, is: .optional, ofType: .string),
      .field(userModel.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(userModel.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}

extension UserModel: ModelIdentifiable {
  public typealias IdentifierFormat = ModelIdentifierFormat.Default
  public typealias IdentifierProtocol = DefaultModelIdentifier<Self>
}
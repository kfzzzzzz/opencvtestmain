// swiftlint:disable all
import Amplify
import Foundation

extension Message {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case body
    case sender
    case dateTime
    case chatroomID
    case createdAt
    case updatedAt
    case messageSenderId
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let message = Message.keys
    
    model.authRules = [
      rule(allow: .private, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "Messages"
    
    model.attributes(
      .index(fields: ["chatroomID"], name: "byChatRoom"),
      .primaryKey(fields: [message.id])
    )
    
    model.fields(
      .field(message.id, is: .required, ofType: .string),
      .field(message.body, is: .optional, ofType: .string),
      .hasOne(message.sender, is: .optional, ofType: UserTest.self, associatedWith: UserTest.keys.id, targetNames: ["messageSenderId"]),
      .field(message.dateTime, is: .optional, ofType: .dateTime),
      .field(message.chatroomID, is: .required, ofType: .string),
      .field(message.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(message.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(message.messageSenderId, is: .optional, ofType: .string)
    )
    }
}

extension Message: ModelIdentifiable {
  public typealias IdentifierFormat = ModelIdentifierFormat.Default
  public typealias IdentifierProtocol = DefaultModelIdentifier<Self>
}
// swiftlint:disable all
import Amplify
import Foundation

public struct UserModel: Model {
  public let id: String
  public var UserPhoneNumber: String
  public var UserName: String
  public var UserImage: String?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      UserPhoneNumber: String,
      UserName: String,
      UserImage: String? = nil) {
    self.init(id: id,
      UserPhoneNumber: UserPhoneNumber,
      UserName: UserName,
      UserImage: UserImage,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      UserPhoneNumber: String,
      UserName: String,
      UserImage: String? = nil,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.UserPhoneNumber = UserPhoneNumber
      self.UserName = UserName
      self.UserImage = UserImage
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}
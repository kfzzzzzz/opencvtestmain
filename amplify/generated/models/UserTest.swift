// swiftlint:disable all
import Amplify
import Foundation

public struct UserTest: Model {
  public let id: String
  public var userName: String?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      userName: String? = nil) {
    self.init(id: id,
      userName: userName,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      userName: String? = nil,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.userName = userName
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}
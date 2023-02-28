// swiftlint:disable all
import Amplify
import Foundation

public struct ChatRoom: Model {
  public let id: String
  public var memberIds: [String]?
  public var Messages: List<Message>?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      memberIds: [String]? = nil,
      Messages: List<Message>? = []) {
    self.init(id: id,
      memberIds: memberIds,
      Messages: Messages,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      memberIds: [String]? = nil,
      Messages: List<Message>? = [],
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.memberIds = memberIds
      self.Messages = Messages
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}
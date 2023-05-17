// swiftlint:disable all
import Amplify
import Foundation

public struct Message: Model {
  public let id: String
  public var body: String?
  public var dateTime: Temporal.DateTime?
  public var chatroomID: String
  public var senderName: String?
  public var senderId: String?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      body: String? = nil,
      dateTime: Temporal.DateTime? = nil,
      chatroomID: String,
      senderName: String? = nil,
      senderId: String? = nil) {
    self.init(id: id,
      body: body,
      dateTime: dateTime,
      chatroomID: chatroomID,
      senderName: senderName,
      senderId: senderId,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      body: String? = nil,
      dateTime: Temporal.DateTime? = nil,
      chatroomID: String,
      senderName: String? = nil,
      senderId: String? = nil,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.body = body
      self.dateTime = dateTime
      self.chatroomID = chatroomID
      self.senderName = senderName
      self.senderId = senderId
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}
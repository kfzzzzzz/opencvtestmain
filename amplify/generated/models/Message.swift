// swiftlint:disable all
import Amplify
import Foundation

public struct Message: Model {
  public let id: String
  public var body: String?
  public var dateTime: Temporal.DateTime?
  public var chatroomID: String
  public var senderId: String?
  public var senderNam: String?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      body: String? = nil,
      dateTime: Temporal.DateTime? = nil,
      chatroomID: String,
      senderId: String? = nil,
      senderNam: String? = nil) {
    self.init(id: id,
      body: body,
      dateTime: dateTime,
      chatroomID: chatroomID,
      senderId: senderId,
      senderNam: senderNam,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      body: String? = nil,
      dateTime: Temporal.DateTime? = nil,
      chatroomID: String,
      senderId: String? = nil,
      senderNam: String? = nil,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.body = body
      self.dateTime = dateTime
      self.chatroomID = chatroomID
      self.senderId = senderId
      self.senderNam = senderNam
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}
// swiftlint:disable all
import Amplify
import Foundation

public struct NewTestModel: Model {
  public let id: String
  public var kfz_name: String?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      kfz_name: String? = nil) {
    self.init(id: id,
      kfz_name: kfz_name,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      kfz_name: String? = nil,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.kfz_name = kfz_name
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}
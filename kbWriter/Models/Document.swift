import Foundation
import SwiftData

@Model
final class Document: Identifiable {
	var id: UUID = UUID()
	var timestamp: Date
	var title: String
	var status: Status
	var tags: [String]
	var body: String
    
	init(timestamp: Date, title: String, status: Status, tags: [String], body: String) {
		self.timestamp = timestamp
		self.title = title
		self.status = status
		self.tags = tags
		self.body = body
	}

}

enum Status: Codable {
	case idea
	case writing
	case editing
	case published
}


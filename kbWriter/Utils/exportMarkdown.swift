import Foundation
import AppKit

func exportMarkdown(_ document: Document) {
	let markdownString = """
---
title: '\(document.title)'
pubDate: '\(formatDateToString(date: document.timestamp))'
tags: ['\(document.tags.joined(separator: "', '"))']
---

\(document.body)
"""
	
	if let filePath = chooseFilePath(title: document.title) {
		do {
			try markdownString.write(toFile: filePath, atomically: true, encoding: .utf8)
		} catch {
			print("Error: \(error.localizedDescription)")
		}
	}
}

func chooseFilePath(title: String) -> String? {
	let savePanel = NSSavePanel()
	savePanel.allowedContentTypes = [.plainText]
	savePanel.nameFieldStringValue = "\(toKebabCase(title)).md"
	
	if savePanel.runModal() == .OK {
		return savePanel.url?.path
	}
	
	return nil
}

func toKebabCase(_ input: String) -> String {
	let lowercased = input.lowercased()
	let alphanumericString = lowercased.replacingOccurrences(of: "[^a-zA-Z0-9]", with: "-", options: .regularExpression)
	let removedExtraHyphens = alphanumericString.replacingOccurrences(of: "--", with: "-")
	return removedExtraHyphens
}

func formatDateToString(date: Date) -> String {
	let dateFormatter = DateFormatter()
	dateFormatter.dateFormat = "MM/dd/yy"
	
	return dateFormatter.string(from: date)
}

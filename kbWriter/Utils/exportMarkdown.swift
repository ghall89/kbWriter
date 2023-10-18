import Foundation

func exportMarkdown(document: Document) {
	let markdownString = """
---
title: \(document.title)
pubDate: \(formatDateToString(date: document.timestamp))
tags: []
---

\(document.body)
"""
}

func formatDateToString(date: Date) -> String {
	let dateFormatter = DateFormatter()
	dateFormatter.dateFormat = "MM/dd/yy"
	
	return dateFormatter.string(from: date)
}

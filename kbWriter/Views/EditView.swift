import SwiftUI
import CodeEditor

struct EditView: View {
	@Bindable var document: Document
	@State private var showDatePicker: Bool = false
	
	var body: some View {
		HStack {
			CodeEditor(
				source: $document.body,
				language: .markdown,
				theme: .default,
				autoPairs: ["_" : "_", "*" : "*", "[" : "]", "(" : ")", "`" : "`"]
			)
			.frame(maxWidth: 900)
		}
		.frame(maxWidth: .infinity)
		.navigationTitle(document.title)
		.toolbar {
			Menu(content: {
				ForEach(blogTags, id: \.self) { tag in
					Button(action: {
						if document.tags.contains(tag) {
							document.tags.removeAll { $0 == tag }
						} else {
							document.tags.append(tag)
						}
					}, label: {
						if document.tags.contains(tag) {
							Image(systemName: "checkmark")
						}
						Text(tag)
					})
				}
			}, label: {
				Image(systemName: "tag")
			})
			Menu(content: {
				Text(document.timestamp, style: .date)
				Divider()
				Button("Set to Today", action: {
					let today = Date()
					document.timestamp = today
				})
				Button("Select Date", action: {
					showDatePicker.toggle()
				})
			}, label: {
				Image(systemName: "calendar")
			})
			Button(action: {
				exportMarkdown(document)
			}, label: {
				Image(systemName: "square.and.arrow.down")
			})
		}
		.sheet(isPresented: $showDatePicker, content: {
			DatePicker(
				"Date",
				selection: $document.timestamp,
				displayedComponents: [.date]
			)
			.datePickerStyle(.graphical)
			.padding()
		})
	}
}

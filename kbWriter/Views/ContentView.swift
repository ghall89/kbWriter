import SwiftUI
import SwiftData

struct ContentView: View {
	@Environment(\.modelContext) private var modelContext
	@Query private var items: [Document]
	
	@State private var selectedRenameId: UUID? = nil
	@State private var selectedRenameString: String = ""
	
	var body: some View {
		NavigationStack {
			
			HStack(spacing: 10) {
				KanbanColumn(header: "Ideas", status: .idea, idToRename: $selectedRenameId, renameString: $selectedRenameString)
				KanbanColumn(header: "Writing", status: .writing, idToRename: $selectedRenameId, renameString: $selectedRenameString)
				KanbanColumn(header: "Editing", status: .editing, idToRename: $selectedRenameId, renameString: $selectedRenameString)
				KanbanColumn(header: "Published", status: .published, idToRename: $selectedRenameId, renameString: $selectedRenameString)
			}
			.padding()
			.toolbar {
				ToolbarItem {
					Button(action: addItem) {
						Label("Add Item", systemImage: "plus")
					}
				}
			}
		}
		.frame(minWidth: 1200)
	}
	
	
	private func addItem() {
		withAnimation {
			let newItem = Document(timestamp: Date(), title: "New Document", status: .idea, tags: [], body: "")
			modelContext.insert(newItem)
		}
	}
}


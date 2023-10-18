import SwiftUI
import SwiftData

struct KanbanColumn: View {
	@Environment(\.modelContext) private var modelContext
	@Query private var items: [Document]
	
	var header: String
	var status: Status
	
	@State private var isTarget: Bool = false
	
	@Binding var idToRename: UUID?
	@Binding var renameString: String
	
	var body: some View {
		VStack(spacing: 0) {
			HStack {
				Text(header)
					.font(.headline)
					.padding()
			}
			Divider()
			ScrollView {
				VStack {
					ForEach(items.filter {$0.status == status}) { item in
						HStack {
							VStack(alignment: .leading) {
								if idToRename == item.id {
									TextField("", text: $renameString)
										.onSubmit {
											items.first(where: { $0.id == item.id })!.title = renameString
											idToRename = nil
											renameString = ""
										}
								} else {
									Text(item.title)
										.font(.headline)
								}
								Text(item.timestamp, style: .date)
							}
							.padding()
							Spacer()
							NavigationLink(destination: EditView(document: item)) {
								Image(systemName: "pencil")
							}
							.padding()
						}
						.background(Material.thick)
						.mask(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
						.frame(maxWidth: .infinity)
						.shadow(radius: 1)
						.draggable(String(describing: item.id))
						.contextMenu(menuItems: {
							Button("Rename", action: {
								idToRename = item.id
								renameString = item.title
							})
							Button("Delete", action: {
								deleteItems(id: item.id)
							})
						})
					}
				}
				.padding()
			}
		}
		.dropDestination(for: String.self, action: { droppedDocs, location in
			for docId in droppedDocs {
				if let doc = items.first(where: { $0.id == UUID(uuidString: docId)}) {
					doc.status = status
				}
			}
			return true
		}, isTargeted: { isTargeted in
			isTarget = isTargeted
		})
		.frame( maxWidth: .infinity, maxHeight: .infinity)
		.background(isTarget ? Material.ultraThick : Material.regular)
		.mask(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
		.shadow(radius: 1)
	}
	
	private func deleteItems(id: UUID) {
		withAnimation {
			if let index = items.firstIndex(where: { $0.id == id }) {
				modelContext.delete(items[index])
			}
		}
	}
}

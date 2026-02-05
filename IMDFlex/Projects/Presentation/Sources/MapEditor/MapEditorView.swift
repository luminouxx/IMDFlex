import SwiftUI
import MapKit
import Domain
import DesignSystem

public struct MapEditorView: View {
    let project: IMDFProject
    
    @State private var cameraPosition: MapCameraPosition = .automatic
    @State private var selectedTool: EditorTool = .select
    
    public init(project: IMDFProject) {
        self.project = project
    }
    
    public var body: some View {
        ZStack {
            // 지도 영역
            Map(position: $cameraPosition) {
                // 추후 IMDF 요소들 렌더링
            }
            .mapStyle(.standard)
            .ignoresSafeArea(edges: .bottom)
            
            // 도구 팔레트
            VStack {
                Spacer()
                EditorToolbar(selectedTool: $selectedTool)
                    .padding()
            }
        }
        .navigationTitle(project.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Menu {
                    Button("내보내기", systemImage: "square.and.arrow.up") {
                        // Export action
                    }
                    Button("설정", systemImage: "gear") {
                        // Settings action
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
        }
    }
}

// MARK: - Editor Tools

enum EditorTool: String, CaseIterable {
    case select = "arrow.up.left.and.arrow.down.right"
    case draw = "pencil"
    case unit = "square.split.2x2"
    case opening = "door.left.hand.open"
    case amenity = "mappin"
    
    var title: String {
        switch self {
        case .select: "선택"
        case .draw: "그리기"
        case .unit: "공간"
        case .opening: "출입구"
        case .amenity: "편의시설"
        }
    }
}

struct EditorToolbar: View {
    @Binding var selectedTool: EditorTool
    
    var body: some View {
        HStack(spacing: 12) {
            ForEach(EditorTool.allCases, id: \.self) { tool in
                Button {
                    selectedTool = tool
                } label: {
                    Image(systemName: tool.rawValue)
                        .font(.title2)
                        .frame(width: 44, height: 44)
                        .background(selectedTool == tool ? Color.imdfPrimary : Color.imdfBackground)
                        .foregroundStyle(selectedTool == tool ? .white : .primary)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .accessibilityLabel(tool.title)
            }
        }
        .padding(8)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

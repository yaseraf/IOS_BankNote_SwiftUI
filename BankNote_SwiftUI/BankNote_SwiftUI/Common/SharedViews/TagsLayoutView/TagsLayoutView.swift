//
//  TagsLayoutView.swift
//  QSC
//
//  Created by Hijjawi97 on 15/09/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import SwiftUI

struct TagsLayoutView: View {
    let tags: [OrderItemFilterUIModel]
    @State private var selectedTags: Set<Int> = []
    @State private var totalHeight = CGFloat.zero
    var body: some View {
        generateTags(tags: tags)
            .frame(height: totalHeight)
        
    }

    private func generateTags(tags: [OrderItemFilterUIModel]) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                ForEach(tags) { tag in
                    TagFillterView(tag: tag, isSelected: .constant(selectedTags.contains(tag.id)))
                        .padding([.horizontal, .vertical], 4)
                        .alignmentGuide(.leading, computeValue: { dimension in
                            // Wrap to the next line if needed
                            if abs(width - dimension.width) > geometry.size.width {
                                width = 0
                                height -= dimension.height
                            }
                            let result = width
                            width -= dimension.width
                            return result
                        })
                        .alignmentGuide(.top, computeValue: { _ in
                            let result = height
                            return result
                        })
                        .onTapGesture {
                            toggleSelection(for: tag)
                        }
                }
            }
            .frame(height: 10)
//            .border(.red)
//            .background(Color.red)
            .background(viewHeightReader($totalHeight))
        }
        .frame(height: 10)
//        .border(.blue)
//        .background(Color.blue)
    }

    private func toggleSelection(for tag: OrderItemFilterUIModel) {
        if selectedTags.contains(tag.id) {
            selectedTags.remove(tag.id)
        } else {
            selectedTags.insert(tag.id)
        }
    }

    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        GeometryReader { geometry -> Color in
            DispatchQueue.main.async {
                binding.wrappedValue = geometry.size.height
            }
            return .clear
        }
    }
}

struct TagsLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleItems = [
            OrderItemFilterUIModel(id: 1, name: "SwiftUI"),
            OrderItemFilterUIModel(id: 2, name: "iOS"),
            OrderItemFilterUIModel(id: 3, name: "Swift"),
            OrderItemFilterUIModel(id: 4, name: "Apple"),
            OrderItemFilterUIModel(id: 5, name: "Mobile Development"),
            OrderItemFilterUIModel(id: 6, name: "kk Development"),
            OrderItemFilterUIModel(id: 7, name: "o Development"),
            OrderItemFilterUIModel(id: 8, name: "Development"),
            OrderItemFilterUIModel(id:9, name: " ad"),
        ]
        TagsLayoutView(tags: sampleItems)
    }
}

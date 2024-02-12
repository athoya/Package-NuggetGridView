//
//  SwiftUIView.swift
//
//
//  Created by Athoya on 24/01/24.
//

import SwiftUI

public struct NuggerItemView: View {
    public var nuggetWidth: CGFloat = 80
    public var nuggetHeight: CGFloat = 50
    public var nuggetCornerRadius: CGFloat = 10
    public var nuggetItem: NuggetItem = NuggetItem()
    
    public var rowIndex: Int = 0
    public var columIndex: Int = 0
    
    public var onNuggetTap: (Int, Int) -> Void = { row, column in
        print("onNuggedTapped child")
    }
    
    @State var isPopOverShown: Bool = false
    
    public var body: some View {
        RoundedRectangle(cornerRadius: nuggetCornerRadius).fill(nuggetItem.color).frame(width: nuggetWidth, height: nuggetHeight)
            .popover(isPresented: $isPopOverShown, content: {
                Text(nuggetItem.onHoverText)
                    .padding(10)
            })
            .onHover { isHover in
                isPopOverShown = isHover
            }
            .onTapGesture {
                print(nuggetItem.onHoverText)
                onNuggetTap(rowIndex, columIndex)
            }
    }
}

public struct NuggetView: View {
    public var items: [[NuggetItem]] = []
    
    public var nuggetWidth: CGFloat = 80
    public var nuggetHeight: CGFloat = 50
    public var nuggetCornerRadius: CGFloat = 10
    
    public var onNuggetTap: (Int, Int) -> Void = { row, column in
        print("onNuggedTapped parrent")
    }
        
    public var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            VStack(alignment: .leading) {
                ForEach(0 ..< items.count) { rowIndex in
                    HStack {
                        ForEach(0 ..< items[rowIndex].count, id: \.self) { columnIndex in
                            NuggerItemView(nuggetWidth: nuggetWidth, nuggetHeight: nuggetHeight, nuggetCornerRadius: 10, nuggetItem: items[rowIndex][columnIndex], rowIndex: rowIndex, columIndex: columnIndex, onNuggetTap: onNuggetTap)
                        }
                    }
                }
            }
            .padding(.leading, 60)
        }
    }
}

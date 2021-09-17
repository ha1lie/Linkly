//
//  ZoomLinkColorCell.swift
//  Linkly
//
//  Created by Hallie on 9/12/21.
//

import SwiftUI

struct ZoomLinkColorCell: View {
    
    let color: ZoomLinkColor
    
    @Binding var selectedColor: ZoomLinkColor
    
    var body: some View {
        return Button {
            self.selectedColor = self.color
        } label: {
            ZStack {
                Circle()
                    .strokeBorder(self.color.getColor(), lineWidth: (self.color == self.selectedColor ? 2 : 0))
                    .foregroundColor(.none)
                    .frame(width: 20, height: 20)
                Circle()
                    .foregroundColor(self.color.getColor())
                    .frame(width: 12, height: 12)
            }
        }.buttonStyle(PlainButtonStyle())
    }
}

//
//  ZoomLinkCell.swift
//  Linkly
//
//  Created by Hallie on 9/12/21.
//

import SwiftUI

struct ZoomLinkCell: View {
    
    let link: ZoomLink
    
    private func openTheLink() {
        if let u = URL(string: self.link.link) {
            if NSWorkspace.shared.open(u) {
                print("OPENED THE ZOOM LINK")
            } else {
                print("COULDNT OPEN THE ZOOM LINK")
            }
        }
    }
    
    var body: some View {
        return HStack {
            ZoomLinkColorCell(color: self.link.color, selectedColor: Binding.constant(.none))
            Text(self.link.title)
                .font(.system(size: 14))
                .bold()
            Spacer()
        }.padding()
        .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white.opacity(0.2)))
        .onTapGesture(count: 2, perform: {
            self.openTheLink()
        })
        .contextMenu {
            Button {
                self.openTheLink()
            } label: {
                HStack {
                    Image(systemName: "video")
                    Text("Open Meeting")
                }
            }.buttonStyle(PlainButtonStyle())
            
            Divider()
            
            Button {
                withAnimation {
                    ZLM.shared.deleteLink(self.link)
                }
            } label: {
                HStack {
                    Image(systemName: "trash")
                    Text("Delete")
                }.foregroundColor(.red)
            }.buttonStyle(PlainButtonStyle())

        }
    }
}

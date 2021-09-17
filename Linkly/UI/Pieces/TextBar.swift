//
//  TextBar.swift
//  Linkly
//
//  Created by Hallie on 9/12/21.
//

import SwiftUI

struct TextBar: View {
    
    let title: String
    @Binding var searchText: String
    
    @State var isEditing: Bool = false
    
    //View constants
    let imageSize: CGFloat = 14
    
    var body: some View {
        return ZStack {
            RoundedRectangle(cornerRadius: 6)
                .foregroundColor(.white.opacity(0.3))
            HStack {
                TextField(self.title, text: self._searchText)
                    .padding(.vertical, 7)
                    .textFieldStyle(PlainTextFieldStyle())
                
                Spacer()
                
                if self.searchText != "" {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .font(.system(size: self.imageSize))
                        .onTapGesture {
                            self.searchText = ""
                        }
                }
                
            }.padding(.horizontal, 8)
        }.frame(maxHeight: 32)
    }
}

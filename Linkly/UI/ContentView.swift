//
//  ContentView.swift
//  Linkly
//
//  Created by Hallie on 9/11/21.
//

import SwiftUI
import LaunchAtLogin

struct ContentView: View {
    
    @Environment(\.colorScheme) var darkMode
    
    @ObservedObject var zlm: ZLM = ZLM.shared
    private let allColors: [ZoomLinkColor] = [.blue, .green, .yellow, .orange, .purple, .pink, .red, .black, .gray]
    
    @State var isAddingLink: Bool = false
    @State var newTitle: String = ""
    @State var newLink: String = ""
    @State var newColor: ZoomLinkColor = .blue
    
    @State var showError: Bool = false
    @State var errorTitle: String = ""
    @State var errorBody: String = ""
    
    @State var confirmClose: Bool = false
    
    @State var userName: String = ""
    
    @State var needsOnboarding: Bool = false
    
    private func addNewLink() {
        if self.newLink.contains("https://") || self.newLink.contains("http://") {
            let newZoomLink = ZoomLink(withTitle: self.newTitle, forLink: self.newLink, id: UUID().uuidString, ofColor: self.newColor)
            withAnimation {
                self.zlm.addLink(newZoomLink)
                self.isAddingLink = false
            }
            self.newLink = ""
            self.newTitle = ""
            self.showError = false
            self.errorBody = ""
            self.errorTitle = ""
        } else {
            self.errorTitle = "Formatting Issue"
            self.errorBody = "Please ensure that your link is prefaced with \"https://\""
            self.showError.toggle()
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if self.needsOnboarding {
                OnboardingView {
                    withAnimation {
                        self.needsOnboarding = false
                    }
                }
            } else {
                HStack {
                    Text(self.userName)
                        .font(.title)
                        .bold()
                    Spacer()
                    Button(action: {
                        self.confirmClose = true
                    }, label: {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(self.darkMode == .dark ? .white.opacity(0.2) : .black.opacity(0.2))
                            .font(.system(size: 12))
                    }).buttonStyle(PlainButtonStyle())
                }.alert(isPresented: self.$confirmClose, content: {
                    Alert(title: Text("Are you sure you want to quit?"), primaryButton: .cancel(Text("Cancel")), secondaryButton: .destructive(Text("Quit").bold(), action: {
                        NSApp.stop(nil)
                    }))
                })
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        ForEach(self.zlm.zoomLinks, id: \.self) { link in
                            //Make a thingy
                            ZoomLinkCell(link: link)
                        }
                        
                        Button {
                            withAnimation {
                                self.isAddingLink.toggle()
                            }
                        } label: {
                            HStack {
                                Image(systemName: "plus.square.fill")
                                    .font(.system(size: 20))
                                Text("Add A Link")
                                    .font(.system(size: 16))
                                    .bold()
                                Spacer()
                            }.padding()
                            .foregroundColor(.accentColor)
                            .background(RoundedRectangle(cornerRadius: 4).foregroundColor(.white.opacity(0.2)))
                        }.buttonStyle(PlainButtonStyle())
                        
                        if self.isAddingLink {
                            VStack(spacing: 8) {
                                TextBar(title: "Title", searchText: self.$newTitle)
                                TextBar(title: "Link", searchText: self.$newLink)
                                
                                HStack(alignment: .center) {
                                    ForEach(0..<self.allColors.count, id: \.self) { i in
                                        ZoomLinkColorCell(color: self.allColors[i], selectedColor: self.$newColor)
                                    }
                                }
                                
                                if self.showError {
                                    VStack(alignment: .leading) {
                                        Text(self.errorTitle)
                                            .bold()
                                        Text(self.errorBody)
                                    }
                                }
                                
                                Button {
                                    self.addNewLink()
                                } label: {
                                    HStack {
                                        Image(systemName: "plus")
                                            .font(.system(size: 20))
                                        Text("Add Link")
                                            .font(.system(size: 16))
                                            .bold()
                                        Spacer()
                                    }.foregroundColor(.white)
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 6).foregroundColor(.accentColor))
                                }.buttonStyle(PlainButtonStyle())

                            }.padding(8).background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white.opacity(0.2)))
                        }
                    }.padding(.bottom)
                }
            }
        }.frame(width: 400, height: 400)
        .padding([.top, .horizontal])
        .onAppear {
            self.needsOnboarding = self.zlm.isFirstLaunch()
            let username = NSUserName()
            self.userName = "\(username)'\(username.last == "s" ? "" : "s") Links"
        }
    }
}

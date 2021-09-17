//
//  OnboardingView.swift
//  Linkly
//
//  Created by Hallie on 9/13/21.
//

import SwiftUI
import LaunchAtLogin

struct OnboardingView: View {
    
    @ObservedObject private var launchAtLogin = LaunchAtLogin.observable
    
    let setFinished: () -> Void
    
    var body: some View {
        return HStack {
            Spacer()
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    Text("Welcome to Linkly")
                        .bold()
                        .font(.title)
                        .padding(.bottom, 10)
                    
                    Text("Store all of your links in an easy to get to place")
                    
                    HStack {
                        Image(systemName: "lock")
                            .font(.system(size: 20))
                        Text("Securely stored on your device, never sent to the cloud")
                            .bold()
                        Spacer()
                    }.padding(16)
                    
                    HStack {
                        Image(systemName: "speedometer")
                            .font(.system(size: 20))
                        Text("Streamline your work, everything in one place")
                            .bold()
                        Spacer()
                    }.padding(16)
                    
                    HStack {
                        Image(systemName: "paintpalette")
                            .font(.system(size: 20))
                        Text("Color coded just to your liking")
                            .bold()
                        Spacer()
                    }.padding(16)
                    
                    HStack {
                        Image(systemName: "cursorarrow.rays")
                            .font(.system(size: 20))
                        Text("Double click to open your link")
                            .bold()
                        Spacer()
                    }.padding(16)
                    
                    HStack {
                        Image(systemName: "trash")
                            .font(.system(size: 20))
                        Text("Right click to delete when you don't need it")
                            .bold()
                        Spacer()
                    }.padding(16)
                    
                    Toggle(isOn: self.$launchAtLogin.isEnabled) {
                        Text("Enable Launch At Login")
                            .bold()
                    }
                    
                    Button {
                        self.setFinished()
                    } label: {
                        HStack {
                            Spacer()
                            Text("Finish")
                                .font(.system(size: 16))
                                .bold()
                            Spacer()
                        }.foregroundColor(.white)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 6).foregroundColor(.accentColor))
                    }.buttonStyle(PlainButtonStyle())
                }.padding(.bottom, 50)
            }.frame(width: 300)
            Spacer()
        }.onAppear {
            self.launchAtLogin.isEnabled = true
        }
    }
}

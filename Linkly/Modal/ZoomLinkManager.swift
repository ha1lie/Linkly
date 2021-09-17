//
//  ZoomLinkManager.swift
//  Linkly
//
//  Created by Hallie on 9/12/21.
//

import Foundation

class ZLM: ObservableObject {
    static let shared: ZLM = ZLM()
    
    @Published var zoomLinks: [ZoomLink] = []
    
    init() {
        //setup the zoom links from storage
        if let linkdata = UserDefaults.standard.data(forKey: "ZoomLinks") {
            self.zoomLinks = (try? PropertyListDecoder().decode([ZoomLink].self, from: linkdata)) ?? []
        }
    }
    
    public func addLink(_ l: ZoomLink) {
        self.zoomLinks.append(l)
        UserDefaults.standard.set(try? PropertyListEncoder().encode(self.zoomLinks), forKey: "ZoomLinks")
    }
    
    public func deleteLink(_ l: ZoomLink) {
        if let i = self.zoomLinks.firstIndex(of: l) {
            self.zoomLinks.remove(at: i)
            UserDefaults.standard.set(try? PropertyListEncoder().encode(self.zoomLinks), forKey: "ZoomLinks")
        }
    }
    
    public func isFirstLaunch() -> Bool {
        let first = UserDefaults.standard.bool(forKey: "IsFirstLaunch")
        if !first {
            UserDefaults.standard.set(true, forKey: "IsFirstLaunch")
        }
        return !first
    }
    
}

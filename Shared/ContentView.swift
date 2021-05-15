//
//  ContentView.swift
//  Shared
//
//  Created by Seogun Kim on 2021/05/15.
//

import SwiftUI

struct ContentView: View {
    
    
    @AppStorage("name") var currentUserName: String?
    let forkeys: String = "name"
    
    var body: some View {
        VStack(spacing: 20) {
            Text(currentUserName ?? "이곳에 이름을 추가할 수 있습니다.")
            
            if let name = currentUserName {
                Text(name)
            }
            
            Button(action: {
                let name = "포뇨"
                currentUserName = name
//                UserDefaults.standard.set(name, forKey: forkeys)
                
            }, label: {
                Text("저장")
            })
//            .onAppear {
//                currentUserName = UserDefaults.standard.string(forKey: forkeys)
//            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

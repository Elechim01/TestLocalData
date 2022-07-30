//
//  ContentView.swift
//  TestLocalData
//
//  Created by Michele Manniello on 09/07/22.
//

import SwiftUI
import CryptoKit

struct ContentView: View {
   
    @ObservedObject var model = HomeViewModel()
    
//    Genero url
    
    var body: some View {
        VStack{
            Spacer()
            Spacer()
            
            Button {
                model.saveFile()
                model.readFile()
                
            } label: {
                Text("Save text")
                
            }
            
            Text("Testo file: \(model.code)")
                .padding()
            
            Button {
//                model.saveJSONFile()
//                model.readJSONFile()
                model.EncryptingAndSave()
                model.readingEndDecripting()
                
            } label: {
                Text("Save JSOn")
            }
            List(model.persone){ e in
                VStack{
                    Text(e.name)
                    Text(e.surname)
                    Text("\(e.age)")
                }
            }


        }
        .onAppear {
            model.url = model.getDocumentsDirectory().appendingPathComponent("text.txt")
            model.readFile()
            if(model.code.isEmpty){
                model.code = NSUUID().uuidString
                model.saveFile()
            }
            
        }
    }
   
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

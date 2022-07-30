//
//  HomeViewModel.swift
//  TestLocalData
//
//  Created by Michele Manniello on 10/07/22.
//

import SwiftUI
import RNCryptor

class HomeViewModel : ObservableObject{
    
    var url : URL?
    @Published var code : String  = ""
    @Published var persone : [Person] = []    
    
    func getDocumentsDirectory() -> URL{
//        find all possible documents directories for ths user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        Just send back the first one, witch ought to be only one
        return paths[0]
    }
    
    func saveFile(){
//               MARK: Salvo i file
        do{
            try code.write(to: url!,atomically: true,encoding: .utf8)
            let input = try String(contentsOf: url!)
            print(input)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func readFile(){
        do{
            self.code = try String(contentsOf: url!,encoding: .utf8)
            
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func saveCryptedfile(){
//         ottengo il path
        let url = getDocumentsDirectory().appendingPathComponent("text.txt")
        let str = "Test Message Cripted"
        do{
            try (url as NSURL).setResourceValue(URLFileProtection.complete,forKey: .fileProtectionKey)
            
            try str.write(to: url,atomically: true,encoding: .utf8)
            
        }catch{
            print(error)
        }
        
        
    }
    
//    JSON File
    func saveJSONFile(){
        let url = getDocumentsDirectory().appendingPathComponent("test.json")
//    salvo il file JSON:
//        Salvo il file JSON criptato
        do{
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(persons)
            try jsonData.write(to: url)
            print(jsonData)
            
        }catch{
            print(error.localizedDescription)
        }
        
        
    }
    
    func readJSONFile(){
        let url = getDocumentsDirectory().appendingPathComponent("test.json")
        do{
            let jsonData = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let personContainer = try decoder.decode([Person].self, from: jsonData)
            
            self.persone = personContainer
        }catch{
            print(error.localizedDescription)
        }
     
    }
    
//    Ecripting JSON and save
    func EncryptingAndSave(){
        let url = getDocumentsDirectory().appendingPathComponent("test.json")
        do{
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(persons)
            let cipheretext = RNCryptor.encrypt(data: jsonData, withPassword: code)
            try cipheretext.write(to: url)
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
//    Reading and Decripting
    func readingEndDecripting(){
        let url = getDocumentsDirectory().appendingPathComponent("test.json")
        do{
            let jsonData = try Data(contentsOf: url)
            let originalData = try RNCryptor.decrypt(data: jsonData, withPassword: code)
            let decoder = JSONDecoder()
            let personContainer = try decoder.decode([Person].self, from: originalData)
            self.persone = personContainer
            
        }catch{
            print(error.localizedDescription)
        }
    }
    
}

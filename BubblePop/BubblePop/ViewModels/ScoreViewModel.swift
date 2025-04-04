//
//  ScoreViewModel.swift
//  BubblePop
//
//  Created by susana on 3/4/2025.
//

import SwiftUI

class ScoreViewModel: ObservableObject{
    @Published var records : [Record] = [] // using a Array to store players records
    
    private let fileName = "Scoreboard.json" // naming the file as Scoreboard.json
    
    init(){
        load()
    }
    
    private func load(){
        let fileURL = getFileURL()
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                //get data from the file and let self.records accepts it
                let data = try Data(contentsOf: fileURL)
                self.records = try JSONDecoder().decode([Record].self, from: data)
            } catch {
                // if this file doest exist, then make records wempty
                records = []
            }
        }
    }
    
    // get the document's folder path
    private func getDocumentsURL() -> URL {
            FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }

    // get the full path of file
    private func getFileURL() -> URL {
        getDocumentsURL().appendingPathComponent(fileName)
    }
    
    // add new record
    func addRecord(name:String,score:Int){
        let newRecord = Record(name: name, score: score)
        records.append(newRecord)
        // sort by score
        records.sort { $0.score > $1.score }
        if records.count > 10 {
            // only get the first 10 records
                records = Array(records.prefix(10))
        }
        save()
    }
    
    // save the file
    private func save() {
        do{
            let data = try JSONEncoder().encode(records)
            try data.write(to: getFileURL())
        }catch {
            print("Fail to save the document")
        }
    }
}


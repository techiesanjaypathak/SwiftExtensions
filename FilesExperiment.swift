//
//  main.swift
//  FilesExperiment
//
//  Created by SanjayPathak on 14/01/20.
//  Copyright © 2020 Sanjay. All rights reserved.
//

import Foundation

/* HIGHLIGHTS
 try? String(contentsOfFile: filePath) else { return "" }
 try existingLog.write(toFile: filePath, atomically: true, encoding: .utf8)
 FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
 try? fm.contentsOfDirectory(at: URL(string: path)!, includingPropertiesForKeys: nil, options: .skipsSubdirectoryDescendants)
 try fm.attributesOfItem(atPath: fileName.path)
 guard fm.fileExists(atPath: fromPath, isDirectory: &isDir) || isDir.boolValue == false else { return false }
 try fm.copyItem(at: URL(fileURLWithPath: fromPath), to: URL(fileURLWithPath: toPath))
*/

class FileOperations {

    func readLastNLinesInReverseOrder(forFilePath filePath: String, withN n: Int) -> String {
        guard let input = try? String(contentsOfFile: filePath) else { return "" }
        var lines = input.components(separatedBy: "\n")
        guard lines.count > 0 else {return ""}
        lines.reverse()
        var returnStr = ""
        for i in 0..<min(n, lines.count){
            returnStr += "\(lines[i])\n"
        }
        return returnStr
    }
    
    func customLog(_ msg: String){
        let filePath = "/Users/sanjaypathak/Desktop/FilesExperiment/Log.txt"
        var existingLog = (try? String(contentsOfFile:filePath )) ?? ""
        existingLog.append(contentsOf: "\(Date()) : \(msg)\n")
        do {
            try existingLog.write(toFile: filePath, atomically: true, encoding: .utf8)
        } catch {
            print("Failed to write : \(error.localizedDescription)")
        }
    }
    
    func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    func arrayForFilesCreatedInLast48Hrs(forPath path: String) -> [String] {
        // Use touch -t 201212211111 /Users/sanjaypathak/Desktop/FilesExperiment/Photos/HIM_5307.JPG
        // to change file modification date YYYYMMDDhhmm
        
            var filesInLast48hrs = [String]()
            let fm = FileManager.default
            if let fileNames = try? fm.contentsOfDirectory(at: URL(string: path)!, includingPropertiesForKeys: nil, options: .skipsSubdirectoryDescendants) {
                do {
                    try fileNames.forEach { (fileName) in
                        if fileName.pathExtension.lowercased() == "jpg" || fileName.pathExtension.lowercased() == "jpeg" {
                            let itemAttributes = try fm.attributesOfItem(atPath: fileName.path)
                            if let creationDate = itemAttributes[.modificationDate] as? Date {
                                if creationDate > Date(timeIntervalSinceNow: -2*24*60*60) {
                                    //                            print(fileName)
                                    filesInLast48hrs.append(fileName.lastPathComponent)
                                }
                            }
                        }
                    }
                } catch {
                    print("Failed to get attributes \(error.localizedDescription)")
                }
            }
        return filesInLast48hrs
    }
    
    func copyDirectory(fromDirPath fromPath:String, toDirPath toPath: String) -> Bool {
        let fm = FileManager.default
        var isDir:ObjCBool = false
        guard fm.fileExists(atPath: fromPath, isDirectory: &isDir) || isDir.boolValue == false else { return false }
        do {
            try fm.copyItem(at: URL(fileURLWithPath: fromPath), to: URL(fileURLWithPath: toPath))
        } catch {
            print(error.localizedDescription)
            return false
        }
        return true
    }
}

func main(){
    let fileOperations = FileOperations()
    print(fileOperations.readLastNLinesInReverseOrder(forFilePath:"/Users/sanjaypathak/Desktop/FilesExperiment/PlayersList.rtf" , withN: 3))
    fileOperations.customLog("jumps over the lazy dog.")
    print(fileOperations.getDocumentsDirectory())
    print(fileOperations.arrayForFilesCreatedInLast48Hrs(forPath: "/Users/sanjaypathak/Desktop/FilesExperiment/Photos"))
    _ = fileOperations.copyDirectory(fromDirPath: "/Users/sanjaypathak/Desktop/FilesExperiment/Photos", toDirPath: "/Users/sanjaypathak/Desktop/FilesExperiment/Images")
}

main()

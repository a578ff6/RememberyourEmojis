//
//  Emoji.swift
//  EmojiDictionary
//
//  Created by 曹家瑋 on 2023/10/7.
//

import Foundation

// Emoji 遵從 Codable 協議以支援編碼和解碼操作。
struct Emoji: Codable {
    var symbol: String
    var name: String
    var description: String
    var usage: String
    
    // archiveURL，用於獲取 emojis.plist 的文件路徑。
    static var archiveURL: URL {
        // 獲取文檔目錄的 URL
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        // 在文檔目錄下創建一個名為 "emojis.plist" 的文件的 URL
        let archiveURL = documentsURL.appendingPathComponent("emojis").appendingPathExtension("plist")
        
        print("Emojis are saved at: \(archiveURL.path)")

        return archiveURL
    }
    
    // saveToFile，用於將 Emoji 物件array保存到文件。
    static func saveToFile(emojis: [Emoji]) {
        // PropertyListEncoder 用於編碼。
        let encoder = PropertyListEncoder()
        do {
            let encodedEmojis = try encoder.encode(emojis)              // 嘗試編碼 emojis
            try encodedEmojis.write(to: archiveURL)                     // 嘗試將編碼後的數據寫入文件
        } catch {
            print("Error encoding emojis: \(error)")                    // 編碼錯誤
        }
    }
    
    // loadFromFile，用於從文件中加載 Emoji 物件array。
    static func loadFromFile() -> [Emoji]? {
        // 嘗試讀取文件數據
        guard let emojiData = try? Data(contentsOf: Emoji.archiveURL) else { return nil }
        
        // 嘗試解碼數據
        do {
            let decoder = PropertyListDecoder()
            let decodedEmojis = try decoder.decode([Emoji].self, from: emojiData)       // 嘗試將讀取的數據解碼為 Emoji 物件array
            return decodedEmojis
        } catch {
            print("Error decoding emojis: \(error)")                                    // 解碼錯誤
            return nil
        }
    }
    
    // sampleEmojis，用於提供一個預定義的 Emoji 物件array。
    static var sampleEmojis: [Emoji] {
        return [
            Emoji(symbol: "😀", name: "Grinning Face",description: "A typical smiley face.", usage: "happiness"),
            Emoji(symbol: "😕", name: "Confused Face",description: "A confused, puzzled face.", usage: "unsurewhat to think; displeasure"),
            Emoji(symbol: "😍", name: "Heart Eyes",description: "A smiley face with hearts for eyes.",usage: "love of something; attractive"),
            Emoji(symbol: "🧑‍💻", name: "Developer",description: "A person working on a MacBook (probably using Xcode to write iOS apps in Swift).", usage: "apps, software,programming"),
            Emoji(symbol: "🐢", name: "Turtle", description: "A cute turtle.", usage: "something slow"),
            Emoji(symbol: "🐘", name: "Elephant", description: "A gray elephant.", usage: "good memory"),
            Emoji(symbol: "🍝", name: "Spaghetti", description: "A plate of spaghetti.", usage: "spaghetti"),
            Emoji(symbol: "🎲", name: "Die", description: "A single die.", usage: "taking a risk, chance; game"),
            Emoji(symbol: "⛺️", name: "Tent", description: "A small tent.", usage: "camping"),
            Emoji(symbol: "📚", name: "Stack of Books", description: "Three colored books stacked on each other.", usage: "homework, studying"),
            Emoji(symbol: "💔", name: "Broken Heart", description: "A red, broken heart.", usage: "extreme sadness"),
            Emoji(symbol: "💤", name: "Snore", description: "Three blue \'z\'s.", usage: "tired, sleepiness"),
            Emoji(symbol: "🏁", name: "Checkered Flag", description: "A black-and-white checkered flag.", usage: "completion")
        ]
    }
}


/*
 1. 使 Emoji 結構體遵從 Codable 協定。
 2. 在模型中，作為靜態方法，實現儲存和讀取的功能：
     - 增加一個 saveToFile(emojis:) 的靜態方法，它接受一個Emoji物件的陣列作為參數。
     - 接著，增加一個 loadFromFile() 靜態方法，它不接受任何參數，但返回一個Emoji物件的陣列。

 3. 利用 PropertyListEncoder 和 PropertyListDecoder 來編碼和解碼你的Emoji物件。
 4. 在 Emoji 結構中增加一個靜態屬性 archiveURL，它應該返回文件的檔案路徑 Documents/emojis.plist。
 5. 填寫 saveToFile(emojis:) 和 loadFromFile() 的方法內容，使用 Emoji.archiveURL 作為檔案路徑。
 6. 建立一個靜態的 sampleEmojis 方法，返回一個預定義的 [Emoji] 集合。
 */




/*
 // 方法二：將所有操作放入一個 do-catch 區塊中
 static func loadFromFile() -> [Emoji]? {
     let decoder = PropertyListDecoder()
     do {
         let data = try Data(contentsOf: archiveURL)
         let decodedEmojis = try decoder.decode([Emoji].self, from: data)
         return decodedEmojis
     } catch {
         print("Error decoding emojis: \(error)")
         return nil
     }
 }
 */


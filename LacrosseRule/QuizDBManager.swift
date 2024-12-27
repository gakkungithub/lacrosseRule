//
//  QuizDBManager.swift
//  LacrosseRule
//
//  Created by Gaku Takahashi on 2024/12/27.
//

import Foundation
import SQLite3

struct Question {
    var question: String
    var answer: Int32
    var image: NSData
}

class QuizDBManager: ObservableObject{
    var db: OpaquePointer?
    private let dbFileName = "quiz.db"
    
    func openDB() -> String {
        // プロジェクトに組み込んでおいた db ファイルを読みこみ
        guard let bundleURL = Bundle.main.url(forResource: "quiz", withExtension: "db"),
              let bundleData = try? Data(contentsOf: bundleURL),
              let documentDirectoryURL = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) else {
            return ""
        }

        // シミュレーター or 実機環境の `documentDirectory` へのパスを取得
        let fileURL = documentDirectoryURL.appendingPathComponent(dbFileName)
        // プロジェクトに組み込んだ db ファイルを `documentDirectory` 配下に配置
        try? bundleData.write(to: fileURL)

        guard sqlite3_open(fileURL.path, &db) == SQLITE_OK else {
            return ""
        }
        return fileURL.path
    }
    
    func select() -> [Question]{
        let queryString = "SELECT question_text, correct_answer, image FROM questions INNER JOIN answers USING (question_id)"
        var stmt: OpaquePointer?
        var questions = [Question]()
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            return []
        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let question = String(cString: sqlite3_column_text(stmt, 0))
            let answer = sqlite3_column_int(stmt, 1)
            
            let blobData = sqlite3_column_blob(stmt, 2)
            let length = sqlite3_column_bytes(stmt, 2)
            let image = NSData(bytes: blobData, length: Int(length))
            questions.append(Question(question: question, answer: answer, image: image))
        }
        
        return questions
    }
}

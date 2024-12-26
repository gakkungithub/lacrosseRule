import Foundation
import SQLite3

struct Question {
    var question: String
    var answer: Int32
    var image: NSData
}

class QuizDBManager: ObservableObject{
    var db: OpaquePointer? = nil
    let dbfile: String = "quiz.db"
    
    func openDB() -> String {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(dbfile)
        if sqlite3_open(fileURL.path, &db) == SQLITE_OK {
            return fileURL.path
        }
        else{
            return fileURL.path
        }
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

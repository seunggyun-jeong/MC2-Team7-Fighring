

import Foundation
import CoreData
import SwiftUI

class DataController: ObservableObject{
    let container = NSPersistentContainer(name: "QuestionModel")
    
    init(){
        container.loadPersistentStores{ desc, error in
            if let error = error{
                print("Failed to load data \(error.localizedDescription)")
            }
        }
    }
    
    
    func save(context: NSManagedObjectContext){
        do{
            try context.save()
            print("Data Saved!")
        }catch{
            print("Could not save the data")
        }
    }
    
    func answerQuestion(question: Question, questionAnswer: Int32, questionNum: Int32, userReason: String, userEmotion: Int32, context: NSManagedObjectContext){
    
        question.isSolved = true
        question.questionAnswer = questionAnswer
        question.questionNum = questionNum
        question.userReason = userReason
        question.userEmotion = userEmotion
        
        save(context: context)
        print("Saved")
    }
    
    func createQuestion(questionNum: Int32, openedDate: String, isOpened: Bool, context: NSManagedObjectContext){
        let question = Question(context: context)
        
        question.openedDate = openedDate
        question.id = UUID()
        question.isSolved = false
        question.isOpened = isOpened
        question.questionNum = questionNum
        
        save(context: context)
        print("Saved")
    }
    
    func resetCoreData(viewContext: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Question")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try viewContext.execute(batchDeleteRequest)
            try viewContext.save()
            print("Core Data reset successful.")
        } catch {
            print("Core Data reset failed: \(error.localizedDescription)")
        }
    }
    
    func addData(context: NSManagedObjectContext) {
        let numbers = (0...35)
        for number in numbers{
            if number == 0 {
                createQuestion(questionNum: Int32(number+1), openedDate: getCurrentDateTime(), isOpened: true, context: context)
            }else {
                createQuestion(questionNum: Int32(number+1), openedDate: "notOpened", isOpened: false, context: context)
            }
            
        }
        
    }
    func getCurrentDateTime() -> String {
            let formatter = DateFormatter() //객체 생성
            formatter.dateStyle = .long
            formatter.timeStyle = .medium
            formatter.dateFormat = "yyyy-MM-dd" //데이터 포멧 설정
            let str = formatter.string(from: Date()) //문자열로 바꾸기
            
            return str
        }
    
    func saveSharingData(questionNum: Int32, questionAnswer: Int32, letter: String,  context: NSManagedObjectContext){
        let sharingData = Sharing(context: context)
        
        sharingData.id = UUID()
        sharingData.questionNum = questionNum
        sharingData.questionAnswer = questionAnswer
        sharingData.sixLetters = letter
        print(sharingData)
        save(context: context)
        print("Saved")
    }
    
}



import Foundation
import CoreData


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
    
    func answerQuestion(questionAnswer: Int32, questionNum: Int32, userReason: String, userEmotion: Int32, context: NSManagedObjectContext){
        let question = Question(context: context)
        
        question.clearDate = Date()
        question.isSolved = true
        question.questionAnswer = questionAnswer
        question.questionNum = questionNum
        question.userReason = userReason
        question.userEmotion = userEmotion
        
        save(context: context)
        print("Saved")
    }
    
    func createQuestion(questionNum: Int32, context: NSManagedObjectContext){
        let question = Question(context: context)
        
        question.id = UUID()
        question.isSolved = false
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
            createQuestion(questionNum: Int32(number+1), context: context)
        }
    }
    
    
    
    //    func editFood(food: Food, name: String, calories: Double, context: NSManagedObjectContext){
    //
    //        food.date = Date()
    //        food.name = name
    //        food.calories = calories
    //
    //        save(context: context)
    //    }
}

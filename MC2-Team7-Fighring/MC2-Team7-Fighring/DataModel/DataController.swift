

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
    
    func answerQuestion(questionAnswer: Int32, questionNum: Int32, userReason: String,userEmotion: Int32, context: NSManagedObjectContext){
        let que = Question(context: context)
        
        que.id = UUID()
        que.clearDate = Date()
        que.questionAnswer = questionAnswer
        que.questionNum = questionNum
        que.userReason = userReason
        que.userEmotion = userEmotion
        
        save(context: context)
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

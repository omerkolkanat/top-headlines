//
//  CoreDataManager.swift
//  TopHeadlines
//
//  Created by Omer Kolkanat on 18.04.2019.
//  Copyright © 2019 Omer Kolkanat. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let sharedManager = CoreDataManager()
    
    private init() {} // Prevent clients from creating another instance.
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ArticleModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    func insertArticle(article: Article) -> ArticleModel? {
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "ArticleModel",
                                                in: managedContext)!
        let articleManagedObject = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        articleManagedObject.setValue(article.title, forKeyPath: "title")
        articleManagedObject.setValue(article.description, forKeyPath: "desc")
        articleManagedObject.setValue(article.content, forKeyPath: "content")
        articleManagedObject.setValue(URL(string: article.url), forKeyPath: "url")
        if let imageURL = article.urlToImage {
            articleManagedObject.setValue(URL(string: imageURL), forKeyPath: "urlToImage")
        }
        articleManagedObject.setValue(article.publishedAt, forKeyPath: "publishedAt")
        articleManagedObject.setValue(article.source.name, forKeyPath: "sourceName")
        do {
            try managedContext.save()
            return articleManagedObject as? ArticleModel
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func fetchAllArticles() -> [ArticleModel]? {
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ArticleModel")
        
        do {
            let articles = try managedContext.fetch(fetchRequest)
            return articles as? [ArticleModel]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func delete(article: ArticleModel) {
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        managedContext.delete(article)
        
        do {
            try managedContext.save()
        } catch {
            print(error)
        }
    }
    
    func deleteAllArticles() {
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ArticleModel")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results
            {
                if let managedObjectData: NSManagedObject = managedObject as? NSManagedObject {
                    managedContext.delete(managedObjectData)
                }
            }
        } catch let error as NSError {
            print("ArticleModel all data error : \(error) \(error.userInfo)")
        }
    }
    
    func convertToModel(from articleManagedObject: ArticleModel) -> Article? {
        if let sourceName = articleManagedObject.sourceName,
            let title = articleManagedObject.title,
            let url = articleManagedObject.url,
            let urlToImage = articleManagedObject.urlToImage,
            let publishedAt = articleManagedObject.publishedAt {
            return Article(source: Source(id: nil, name: sourceName),
                           author: nil,
                           title: title,
                           description: articleManagedObject.desc,
                           url: url.absoluteString,
                           urlToImage: urlToImage.absoluteString,
                           publishedAt: publishedAt,
                           content: articleManagedObject.content)
        }
        return nil
    }
}

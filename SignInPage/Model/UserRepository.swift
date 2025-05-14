//
//  UserRepository.swift
//  SignInPage
//
//  Created by EMILY on 14/05/2025.
//

import CoreData

final class UserRepository {
    
    private var context: NSManagedObjectContext
    
    init() {
        let persistentContainer = NSPersistentContainer(name: CDKey.container.rawValue)
        persistentContainer.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        context = persistentContainer.viewContext
    }
    
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
                print("[Core Data] context 저장 성공")
            } catch {
                print("[Core Data] context 저장 실패")
            }
        }
    }
    
    func fetchUser() -> UserEntity? {
        let request = NSFetchRequest<UserEntity>(entityName: CDKey.entity.rawValue)
        
        do {
            let entites = try context.fetch(request)
            print("[Core Data] \(entites.count)개 entity fetch 성공")
            return entites.isEmpty ? nil : entites[0]
        } catch {
            print("[Core Data] fetch 실패")
            return nil
        }
    }
    
    func addUser(_ user: User) {
        let entity = UserEntity(context: context)
        
        entity.email = user.email
        entity.password = user.password
        entity.nickname = user.nickname
        
        saveContext()
        
        print("[Core Data] User 추가")
    }
    
    func deleteUser(_ id: NSManagedObjectID) {
        do {
            let user = try context.existingObject(with: id)
            context.delete(user)
            print("[Core Data] User 삭제 성공")
            saveContext()
        } catch {
            print("[Core Data] User 삭제 실패")
        }
    }
    
    private enum CDKey: String {
        case container = "UserContainer"
        case entity = "UserEntity"
    }
}

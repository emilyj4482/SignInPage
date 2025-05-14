//
//  UserRepository.swift
//  SignInPage
//
//  Created by EMILY on 14/05/2025.
//

import CoreData


// 회원가입 정보와 로그인 정보를 관리하는 객체
final class UserRepository {
    
    var context: NSManagedObjectContext
    private let userDefaults = UserDefaults.standard
    
    init() {
        let persistentContainer = NSPersistentContainer(name: CDKey.container.rawValue)
        persistentContainer.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        context = persistentContainer.viewContext
    }
    
    private enum CDKey: String {
        case container = "UserContainer"
        case entity = "UserEntity"
        case loginSaved = "loginSaved"
        case savedUserID = "savedUserID"
    }
    
    var isLoginSaved: Bool {
        return userDefaults.bool(forKey: CDKey.loginSaved.rawValue)
    }
    
    var savedUserID: String? {
        return userDefaults.string(forKey: CDKey.savedUserID.rawValue)
    }
    
    var hasUsers: Bool {
        let request = NSFetchRequest<UserEntity>(entityName: CDKey.entity.rawValue)
        
        do {
            let entites = try context.fetch(request)
            print("[Core Data] \(entites.count)개 entity fetch 성공")
            return entites.isEmpty ? false : true
        } catch {
            print("[Core Data] fetch 실패")
            return false
        }
    }
}

// Core Data 관련 기능
extension UserRepository {
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
    
    func fetchUser(with id: NSManagedObjectID) -> UserEntity? {
        do {
            let user = try context.existingObject(with: id)
            print("[Core Data] NSManagedObjectID로 entity fetch 성공")
            return user as? UserEntity
        } catch {
            print("[Core Data] fetch 실패")
            return nil
        }
    }
    
    func searchUser(with email: String) -> UserEntity? {
        let request = NSFetchRequest<UserEntity>(entityName: CDKey.entity.rawValue)
        request.predicate = NSPredicate(format: "email == %@", email)
        
        do {
            let entites = try context.fetch(request)
            print("[Core Data] email로 검색한 entity fetch 성공")
            return entites.first
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
}

// UserDefaults 관련 기능
extension UserRepository {
    func saveLoginInfo(_ userID: String) {
        userDefaults.set(true, forKey: CDKey.loginSaved.rawValue)
        userDefaults.set(userID, forKey: CDKey.savedUserID.rawValue)
    }
    
    func deleteLoginInfo() {
        userDefaults.set(false, forKey: CDKey.loginSaved.rawValue)
        userDefaults.set(nil, forKey: CDKey.savedUserID.rawValue)
    }
}

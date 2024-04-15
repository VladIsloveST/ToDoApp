//
//  RealmManager.swift
//  TestTask
//
//  Created by Mac on 28.03.2024.
//

import Foundation
import RealmSwift

enum RealmError: Error {
    case withInitializing
    case withCreating
    case withUpdating
    case withDeleting
}

protocol RealmManagerProtocol {
    func create<T: Object>(_ object: T, with title: String, _ objectType: T.Type)
    func read<T: Object>(_ objectType: T.Type) -> List<T>
    func update<T: Object>(_ object: T, with dictionary: [String: Any?])
    func delete<T: Object>(_ object: T)
    func observeChanges<T: Object>(_ objectType: T.Type , handler: @escaping UndefinedAction)
}

final class RealmManager: RealmManagerProtocol, ObservableObject {
    private var token: NotificationToken?
    
    // MARK: - Methods
    private func performAction(_ action: ActionWithRealm) {
        do {
            let realm = try Realm()
            try action(realm)
        } catch {
            print("\(RealmError.withInitializing): \(error)")
        }
    }
    
    func create<T: Object>(_ object: T, with title: String, _ objectType: T.Type) {
        performAction { realm in
            let filteredObjects = realm.objects(objectType).filter("title == %@", title)
            guard filteredObjects.isEmpty else { return }
            
            do {
                try realm.write {
                    realm.add(object)
                }
            } catch {
                print("\(RealmError.withCreating): \(error)")
            }
        }
    }
    
    func read<T: Object>(_ objectType: T.Type) -> List<T> {
        let list = List<T>()
        performAction { realm in
            let results = realm.objects(objectType)
            list.append(objectsIn: results)
        }
        return list
    }
    
    func update<T: Object>(_ object: T, with dictionary: [String: Any?]) {
        performAction { realm in
            do {
                try realm.write {
                    guard let updated = dictionary.first else { return }
                    object.setValue(updated.value, forKey: updated.key)
                }
            } catch {
                print("\(RealmError.withUpdating): \(error)")
            }
        }
    }
    
    func delete<T: Object>(_ object: T) {
        performAction { realm in
            do {
                try realm.write {
                    realm.delete(object)
                }
            } catch {
                print("\(RealmError.withDeleting): \(error)")
            }
        }
    }
    
    func observeChanges<T: Object>(_ objectType: T.Type , handler: @escaping UndefinedAction) {
        performAction { realm in
            token = realm.objects(objectType).observe {_ in
                handler()
            }
        }
    }
}

//
//  Datastore.swift
//  finance
//
//  Created by Erik Radicheski da Silva on 05/01/22.
//

import CoreData

class Datastore {
    
    static public var shared = Datastore()
    
    private var context: NSManagedObjectContext = Persistence.shared.persistentContainer.viewContext
    
    private var data: [UUID?: [PortfolioItem]] = [:]
    
    private init() {
        
        let request = PortfolioItem.createFetchRequest()
        if let data = try? self.context.fetch(request) {
            for item in data {
                self.insert(item)
            }
        }
        
    }
    
    func insert(_ item: PortfolioItem) {
        if self.data.keys.contains(item.parentId) {
            self.data[item.parentId]?.append(item)
            self.data[item.parentId]?.sort(by: { $0.rank < $1.rank } )
        } else {
            self.data[item.parentId] = [item]
        }
    }
    
    func getCount(for parentId: UUID?) -> Int {
        return self.data[parentId]?.count ?? 0
    }
    
    func getElement(for parentId: UUID?, at index: Int) -> PortfolioItem? {
        return self.data[parentId]?[index]
    }
    
    func getElement(for parentId: UUID?) -> [PortfolioItem] {
        guard let array = self.data[parentId] else { return [] }
        return array
    }
    
    func remove(_ item: PortfolioItem) {
        self.context.delete(item)
        self.data[item.parentId]?.removeAll(where: { $0.id == item.id } )
    }
    
}

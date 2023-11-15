//
//  DataHelper.swift
//  DogList
//
//  Created by Juan Jose Elias Navaro on 15/11/23.
//

import Foundation

class DataHelper {
    private init() {}
    
    public static let shared: DataHelper = DataHelper()
    
    func fetchDogs(completion: @escaping ([Dog]) -> Void) {
        let list: [Dog] = DBHelper.shared.getDogs()
        if list.isEmpty {
            print("No dogs in DB, getting from service...")
            Api.shared.getDogList { result in
                switch result {
                case .success(let dogs):
                    self.saveDogs(dogs)
                    completion(dogs)
                case .failure(_):
                    completion([])
                }
            }
        } else {
            completion(list)
        }
    }
    
    private func saveDogs(_ dogs: [Dog]) {
        for dog in dogs {
            DBHelper.shared.insertDog(dog)
        }
    }
}

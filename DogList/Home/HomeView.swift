//
//  HomeView.swift
//  DogList
//
//  Created by Juan Jose Elias Navaro on 15/11/23.
//

import UIKit

class HomeView: UIView {
    unowned var controller: HomeController!
    
    var dogList: [Dog] = []
    
    lazy var tableView: UITableView = {
        let table: UITableView = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        table.backgroundColor = .background
        table.register(DogCell.self, forCellReuseIdentifier: DogCell.identifier)
        return table
    }()
    
    init(controller: HomeController) {
        self.controller = controller
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .background
        
        addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func updateDogs(_ list: [Dog]) {
        dogList = list
        tableView.reloadData()
    }
}

extension HomeView: UITableViewDelegate, UITableViewDataSource {
    
    func dogFor(_ indexPath: IndexPath) -> Dog {
        return dogList[indexPath.row]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: DogCell = tableView.dequeueReusableCell(withIdentifier: DogCell.identifier, for: indexPath) as? DogCell else {
            return UITableViewCell()
        }
        
        let dog: Dog = dogFor(indexPath)
        cell.config(with: dog)
        
        return cell
    }
}

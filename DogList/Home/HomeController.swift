//
//  HomeController.swift
//  DogList
//
//  Created by Juan Jose Elias Navaro on 15/11/23.
//

import UIKit

class HomeController: UIViewController {
    
    weak var viewHome: HomeView?
    
    override func loadView() {
        super.loadView()
        let viewHome: HomeView = HomeView(controller: self)
        self.viewHome = viewHome
        self.view = viewHome
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Dogs We Love"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DataHelper.shared.fetchDogs { dogList in
            DispatchQueue.main.async {
                self.viewHome?.updateDogs(dogList)
            }
        }
    }

}

//
//  UIImageView.swift
//  DogList
//
//  Created by Juan Jose Elias Navaro on 15/11/23.
//

import UIKit

extension UIImageView {
    func downloadImage(_ urlString: String) {
        guard let url: URL = URL(string: urlString) else {
            print("\(urlString) is not a valid URL")
            return
        }
        self.image = nil
        let request: URLRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                print("Error downloading image")
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }.resume()
    }
}

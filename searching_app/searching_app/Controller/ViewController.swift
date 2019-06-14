//
//  ViewController.swift
//  searching_app
//
//  Created by Lizaveta Rudzko on 3/24/1398 AP.
//  Copyright © 1398 Lizaveta Rudzko. All rights reserved.
//

import UIKit

class Film
{
    let title: String
    let year: String
    let descript: String
    let image: String
    
    init(title: String, year: String, descript: String, image: String)
    {
        self.title = title
        self.year = year
        self.descript = descript
        self.image = image
    }
}

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating
{
    @IBOutlet weak var filmsView: UICollectionView!
    
    @IBOutlet weak var searchView: UIView!
    
    
    var filtered:[Film] = []
    var searchActive : Bool = false
    let searchController = UISearchController(searchResultsController: nil)
    
    func updateSearchResults(for searchController: UISearchController)
    {
//        let searchString = searchController.searchBar.text
//        //print("text = ", searchString)
//
//        filtered = films.filter({ (item) -> Bool in
//            let countryText: NSString = item.title as NSString
//
//            return (countryText.range(of: searchString!, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
//        })
        if searchController.searchBar.text! == "" {
            filtered = films
        }
        else {
            filtered = films.filter { $0.title.lowercased().contains(searchController.searchBar.text!.lowercased()) }
        }
        
        self.filmsView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        //if searchActive {
        print(self.filtered.count)
            return self.filtered.count
//        }
//        else
//        {
//            return films.count
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filmcell", for: indexPath) as! filmCell
        
        cell.title.text = filtered[indexPath.row].title
        cell.year.text = filtered[indexPath.row].year
        cell.descript.text = filtered[indexPath.row].descript
        cell.image.image = UIImage.init(named: filtered[indexPath.item].image)!
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool
    {
        print("Row \(indexPath.row) selected")
        return false
    }

    
    var films:[Film] = []
    
    let film1 = Film(title: "Film1", year: "2000", descript: "gg", image: "1.jpg")
    let film2 = Film(title: "Film2", year: "2000", descript: "gg", image: "2.jpg")
    let film3 = Film(title: "Film3", year: "2000", descript: "gg", image: "3.jpg")
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        filmsView.dataSource = self
        filmsView.delegate = self
        
        films.append(film1)
        films.append(film2)
        films.append(film3)
        
        filtered = films
        
        
        searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        self.searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search film"
        searchController.searchBar.sizeToFit()
        searchController.searchBar.becomeFirstResponder()
        self.searchView.addSubview(searchController.searchBar)
        print("!!!")
        //self.filmsView.register(UICollectionViewCell.self, forCellReuseIdentifier: "filmcell")
    }


}


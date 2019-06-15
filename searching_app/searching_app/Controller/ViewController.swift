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
    var amount: Int
    var score: Double
    
    init(title: String, year: String, descript: String, image: String, score: Double)
    {
        self.title = title
        self.year = year
        self.descript = descript
        self.image = image
        self.amount = 0
        self.score = score
    }
}

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating
{
    @IBOutlet weak var filmsView: UICollectionView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var popularView: UICollectionView!
    @IBOutlet weak var infoView: UIView!
    
    @IBOutlet weak var infoImage: UIImageView!
    @IBOutlet weak var infoTitle: UILabel!
    @IBOutlet weak var infoYear: UILabel!
    @IBOutlet weak var infoScore: UILabel!
    @IBOutlet weak var infoDescription: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    
    var cntReloads = 0
    var filtered:[Film] = []
    var sorted:[Film] = []
    let searchController = UISearchController(searchResultsController: nil)
    
    func updateSearchResults(for searchController: UISearchController)
    {
        if searchController.searchBar.text! == "" {
            filtered = films
        }
        else {
            filtered = films.filter {  $0.title.lowercased().contains(searchController.searchBar.text!.lowercased())
            }
        }
        
        self.filmsView.reloadData()
        if cntReloads == 10 {
            self.popularView.reloadData()
            cntReloads = 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if (collectionView == self.filmsView)
        {
            return self.filtered.count
        }
        else
        {
            return min(10, self.films.count)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if (collectionView == self.filmsView)
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filmcell", for: indexPath) as! filmCell
        
            cell.title.text = filtered[indexPath.row].title
            cell.year.text = filtered[indexPath.row].year
            cell.descript.text = filtered[indexPath.row].descript
            cell.image.image = UIImage.init(named: filtered[indexPath.row].image)!
        
            return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "popularcell", for: indexPath) as! popularCell
            sorted = films.sorted(by: {$0.amount > $1.amount})
            cell.title.text = sorted[indexPath.item].title
            cell.image.image = UIImage.init(named: sorted[indexPath.item].image)!
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool
    {
        if (collectionView == self.filmsView)
        {
            var index = films.enumerated().compactMap { $0.element.title == filtered[indexPath.row].title ? $0.offset : nil }
            films[index[0]].amount = films[index[0]].amount + 1
            cntReloads = cntReloads + 1
            
            //print("Row \(indexPath.row) selected")
            //searchView.isHidden = true
            infoView.isHidden = false
            searchView.alpha = 0.0
            //self.searchView.willRemoveSubview(searchController.searchBar)
            infoImage.image = UIImage.init(named:filtered[indexPath.row].image)!
            infoTitle.text = filtered[indexPath.row].title
            infoYear.text = "Year: \(filtered[indexPath.row].year)"
            infoScore.text = "Score: " + String(filtered[indexPath.row].score)
            infoDescription.text = filtered[indexPath.row].descript
            
            
            if cntReloads == 10 {
                self.popularView.reloadData()
                cntReloads = 0
            }
            
            return false
        }
        else
        {
            return false
        }
    }

    
    var films:[Film] = []
    
    let film1 = Film(title: "Film1", year: "2005", descript: "Doctor WHO. 1 season", image: "1.jpg", score: 8.0)
    let film2 = Film(title: "Film2", year: "2006", descript: "Doctor WHO. 2 season", image: "2.jpg", score: 9.3)
    let film3 = Film(title: "Film3", year: "2008", descript: "Doctor WHO. 3 season", image: "3.jpg", score: 9.1)
    let film4 = Film(title: "Film11", year: "2010", descript: "Doctor WHO. 4 season", image: "4.jpg", score: 9.2)
    let film5 = Film(title: "Doctor WHO", year: "2012", descript: "Doctor WHO. 5 season", image: "5.jpg", score: 8.9)
    let film6 = Film(title: "Doctor Who", year: "2013", descript: "Doctor WHO. 6 season", image: "6.jpg", score: 9.2)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        infoView.isHidden = true
        filmsView.dataSource = self
        filmsView.delegate = self
        popularView.dataSource = self
        popularView.delegate = self
        
        films.append(film1)
        films.append(film2)
        films.append(film3)
        films.append(film4)
        films.append(film5)
        films.append(film6)
        
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
        
        //print("!!!")
    }

    @IBAction func backButtonClicked(_ sender: Any) {
        infoView.isHidden = true
        //self.searchView.addSubview(searchController.searchBar)
        //searchView.isHidden = false
    }
    
    
}


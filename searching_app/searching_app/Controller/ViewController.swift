//
//  ViewController.swift
//  searching_app
//
//  Created by Lizaveta Rudzko on 3/24/1398 AP.
//  Copyright © 1398 Lizaveta Rudzko. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating
{
    @IBOutlet weak var filmsView: UICollectionView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var popularView: UICollectionView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var mainTitle: UILabel!
    
    @IBOutlet weak var infoImage: UIImageView!
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
        if cntReloads == 5 {
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
            print("pop_reload")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "popularcell", for: indexPath) as! popularCell
            sorted = films.sorted(by: {$0.amount > $1.amount})
            
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            for flm in sorted
            {
                var _: FilmEntity = FilmEntity(persistentContainer: (appDelegate?.persistentContainer)!, title: flm.title, amount: flm.amount)
            }
            
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
            
            infoView.isHidden = false
            infoImage.image = UIImage.init(named:filtered[indexPath.row].image)!
            self.mainTitle.text = filtered[indexPath.row].title
            infoYear.text = "Year: \(filtered[indexPath.row].year)"
            infoScore.text = "Score: " + String(filtered[indexPath.row].score)
            
            var descriptions: [String: String] = [:]
            var format = PropertyListSerialization.PropertyListFormat.xml
            let plistPath = Bundle.main.path(forResource: "filmsDescriptions", ofType: "plist")
            let plistXML = FileManager.default.contents(atPath: plistPath!)
            do
            {
                descriptions = try PropertyListSerialization.propertyList(from: plistXML!, options: .mutableContainersAndLeaves, format: &format) as! [String: String]
            }
            catch { }
            
            infoDescription.text = descriptions[filtered[indexPath.row].title]
            
            if cntReloads == 5 {
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
    var films_temp:[FilmEnt] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        infoView.isHidden = true
        filmsView.dataSource = self
        filmsView.delegate = self
        popularView.dataSource = self
        popularView.delegate = self
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedContext = (appDelegate?.persistentContainer)!.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FilmEnt")
        films_temp = try! managedContext.fetch(request) as! [FilmEnt]
        
        for flm in films_temp
        {
            let film_temp = Film(title: flm.title!, year: flm.year!, image: flm.image!, descript: flm.descript!, score: flm.score, amount: Int(flm.amount))
            print("amount = ", film_temp.title, " ", film_temp.amount)
            films.append(film_temp)
        }
        
        filtered = films
        
        searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        self.searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search movie"
        searchController.searchBar.sizeToFit()
        searchController.searchBar.becomeFirstResponder()
        self.searchView.addSubview(searchController.searchBar)
    }


    @IBAction func backButtonClicked(_ sender: Any) {
        self.infoView.isHidden = true
        self.mainTitle.text = "MOVIES"
    }
    
}


//
//  InfoViewController.swift
//  searching_app
//
//  Created by Lizaveta Rudzko on 3/25/1398 AP.
//  Copyright © 1398 Lizaveta Rudzko. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController
{

    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var infoImage: UIImageView!
    @IBOutlet weak var infoYear: UILabel!
    @IBOutlet weak var infoScore: UILabel!
    @IBOutlet weak var infoDescription: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var infoTitle: UILabel!
    
    var film = Film(title: "", year: "", image: "", descript: "", score: 0, amount: 0)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        infoImage.image = UIImage.init(named:film.image)!
        self.infoTitle.text = film.title
        infoYear.text = "Year: \(film.year)"
        infoScore.text = "Score: " + String(film.score)
        
        var descriptions: [String: String] = [:]
        var format = PropertyListSerialization.PropertyListFormat.xml
        let plistPath = Bundle.main.path(forResource: "filmsDescriptions", ofType: "plist")
        let plistXML = FileManager.default.contents(atPath: plistPath!)
        do
        {
            descriptions = try PropertyListSerialization.propertyList(from: plistXML!, options: .mutableContainersAndLeaves, format: &format) as! [String: String]
        }
        catch { }
        
        infoDescription.text = descriptions[film.title]
    }
    
    @IBAction func backButtonClicked(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }


}

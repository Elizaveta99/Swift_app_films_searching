//
//  searching_appTests.swift
//  searching_appTests
//
//  Created by Lizaveta Rudzko on 3/24/1398 AP.
//  Copyright © 1398 Lizaveta Rudzko. All rights reserved.
//

import XCTest
import CoreData
@testable import searching_app

class searching_appTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testForFilm()
    {
        let film = Film(title: "title", year: "2005", image: "image", descript: "description", score: 10.0, amount: 0)
        XCTAssertNotNil(film.title)
        XCTAssertNotNil(film.year)
        XCTAssertNotNil(film.image)
        XCTAssertNotNil(film.descript)
        XCTAssertNotNil(film.score)
        XCTAssertNotNil(film.amount)
    }
    
    func testFilmEntity()
    {
        let title: String = "title1"
        let year: String = "2005"
        let image: String = "image"
        let descript: String = "description"
        let score = 10.0
        let amount = 0
        let ap = AppDelegate.init()
        let persistentContainer = ap.persistentContainer
        let testObject = FilmEntity(persistentContainer: persistentContainer, title: title, year: year, image: image, descript: descript, score: score, amount: amount)
        
        XCTAssert(testObject.title()! == title)
        XCTAssert(testObject.year()! == year)
        XCTAssert(testObject.image()! == image)
        XCTAssert(testObject.descript()! == descript)
        XCTAssert(testObject.score()! == score)
        XCTAssert(testObject.amount()! == amount)
        
        testObject.delete(persistentContainer: persistentContainer)
        
        XCTAssert(testObject.title() == nil)
        XCTAssert(testObject.year() == nil)
        XCTAssert(testObject.image() == nil)
        XCTAssert(testObject.descript() == nil)
        XCTAssert(testObject.score() == nil)
        XCTAssert(testObject.amount() == nil)
        
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

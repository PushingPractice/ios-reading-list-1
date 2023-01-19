//
//  BookController.swift
//  ReadingList
//
//  Created by Diante Lewis-Jolley on 1/19/23.
//

import Foundation

class BookController {
    
    
    
    init() {
        loadFromPersistentStore()
    }
    
    var books: [Book] = []
    
    var readingListURL: URL? {
        let fileManager = FileManager.default
        
        // Grab the documents directory - MyUser/Documents/
        let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        
        //Create a unique location for these stars property list (plist) - MyUser/Documents/stars
        let readingListURL = documentsDir?.appendingPathExtension("readingList.plist")
        
        return readingListURL
        
    }
    
    // MARK: - CRUD
    func createBook(withTitle title: String, reasonToRead: String) {
        
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        saveToPersistentStore()
    }
    
    func deleteBook() {
        
    }
    
    private func saveToPersistentStore() {
        do {
           
            let encoder = PropertyListEncoder()
            
            //convert stars into a plist
            let readingPlist = try encoder.encode(books)
            
            // Grab the location we want to save the plist to
            guard let persistentFileUrl = readingListURL else { return }
            
            //Save the file to the documents directory
            try readingPlist.write(to: persistentFileUrl)
            
        } catch let saveError {
            
            // Handle the error that gets 'thrown' here
            // This catch statement will only run if there is an error and the method fails
            print("Error saving stars: \(saveError)")
            
        }

    }
    
    private func loadFromPersistentStore() {
        
        guard let persistentFileURL = readingListURL else { return }
        
        do {
            
            let decoder = PropertyListDecoder()
            
            //Grab the data (plist) from the persistentFileURL
            let readingPlist = try Data(contentsOf: persistentFileURL)
            
            // Turn it from plist to array of stars
            let books = try decoder.decode([Book].self, from: readingPlist)
            
            self.books = books
            
        } catch {
            
            print("Error decoding stars: \(error)")
            
        }
    }
    
    
}

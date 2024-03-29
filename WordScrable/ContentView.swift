//
//  ContentView.swift
//  WordScrable
//
//  Created by Samuel F. Ademola on 12/22/19.
//  Copyright © 2019 Nomizo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    /* -------------------------------------------------
     STATE SECTION
     ----------------------------------------------------*/
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    
    /* -------------------------------------------------
     FUCTIONS SECTION
     ----------------------------------------------------*/
    func addNewWord() {
        
        // lowercase and trim the word, to make sure we do not add duplicate words with case differences
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        // exit if the remianing string is empty
        guard answer.count > 0 else {
            return
        }
        
        // extra validation to come
        usedWords.insert(answer, at: 0)
        newWord = ""
        
        
        /*
         VALIDATION
         */
        // IS ORIGINAL
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        // IS POSSIBLE
        guard isPossible(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        // IS REAL
        guard isReal(word: answer) else {
            wordError(title: "Word not possible", message: "This isn't a real word.")
            return
        }
        
    }
    
    func startGame() {
        // 1. Find the URL for start.txt in our app bundle
        if let startWordURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            
            // 2. Load start.txt into a string
            if let startWords = try? String(contentsOf: startWordURL) {
                
                // 3. Split the string up into an array of strings, splitting on line breaks
                let allWords = startWords.components(separatedBy: "\n")
                
                // 4. Pick one random word, or use "silkwork" as a sensible default
                rootWord = allWords.randomElement() ?? "silkworm"
                
                // If we are here everything has worked, so we can exit
                return
            }
        }
        
        // if were we are "here" then there was a problem - trigger a crashand report the error
        fatalError("Could not load start.txt from bundle")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    /* -------------------------------------------------
     BODY SECTION
     ----------------------------------------------------*/
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
                
                List (usedWords, id:\.self) {
                    Image(systemName: "\($0.count).circle")
                    Text($0)
                }
            }
            .navigationBarTitle(rootWord)
            .onAppear(perform: startGame)
            .alert(isPresented: $showingError) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

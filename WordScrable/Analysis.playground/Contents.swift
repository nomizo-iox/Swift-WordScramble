import UIKit

var str = "Hello, playground"

let input = "a b c"
let letters = input.components(separatedBy: " ")
print(letters)

let letter = letters.randomElement()
print(letter)

let trimmed = letter?.trimmingCharacters(in: .whitespacesAndNewlines)
print(trimmed)

/* There’s one last piece of string functionality I’d like to cover before we dive into the main project, and that is the ability to check for misspelled words.
 
 This functionality is provided through the class UITextChecker. You might not realize this, but the “UI” part of that name carries two additional meanings with it:
 
 This class comes from UIKit. That doesn’t mean we’re loading all the old user interface framework, though; we actually get it automatically through SwiftUI.
 It’s written using Apple’s older language, Objective-C. We don’t need to write Objective-C to use it, but there is a slightly unwieldy API for Swift users.
 Checking a string for misspelled words takes four steps in total. First, we create a word to check and an instance of UITextChecker that we can use to check that string:*/
let word = "swift"
let checker = UITextChecker()


/*
 Second, we need to tell the checker how much of our string we want to check. If you imagine a spellchecker in a word processing app, you might want to check only the text the user selected rather than the entire document.

 However, there’s a catch: Swift uses a very clever, very advanced way of working with strings, which allows it to use complex characters such as emoji in exactly the same way that it uses the English alphabet. However, Objective-C does not use this method of storing letters, which means we need to ask Swift to create an Objective-C string range using the entire length of all our characters, like this:
 
 UTF-16 is what’s called a character encoding – a way of storing letters in a string. We use it here so that Objective-C can understand how Swift’s strings are stored; it’s a nice bridging format for us to connect the two.
 */
let range = NSRange(location: 0, length: word.utf16.count)


/*
 Third, we can ask our text checker to report where it found any misspellings in our word, passing in the range to check, a position to start within the range (so we can do things like “Find Next”), whether it should wrap around once it reaches the end, and what language to use for the dictionary:
 
  That sends back another Objective-C string range, telling us where the misspelling was found. Even then, there’s still one complexity here: Objective-C didn’t have any concept of optionals, so instead relied on special values to represent missing data.
 */
let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")


let allGood = misspelledRange.location == NSNotFound

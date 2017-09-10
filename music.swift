//
//  Music.swift
//  SoloBuilder
//
//  Created by Zack Ulam on 9/9/17.
//  Copyright © 2017 Zack Ulam. All rights reserved.
//

import Foundation
import Darwin

//arrays containing notes by classification
let notesFlats = ["Ab", "A", "Bb", "B", "C", "Db", "D", "Eb", "E", "F", "Gb", "G"];
let notesSharps = ["A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#"];
let notesNats = ["A", "B", "C", "D", "E", "F", "G"];
let allNotes = ["Ab", "A", "Bb", "B", "C", "Db", "D", "Eb", "E", "F", "Gb", "G", "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#"]

var startIndex = 0;

let indexLimit = 12;
var scaleLengthLimit = 7;

//intervals (whole/half steps) for each scale
let ionian = [2, 2, 1, 2, 2, 2, 1];
let dorian = [2, 1, 2, 2, 2, 1, 2];
let phrygian = [1, 2, 2, 2, 1, 2, 2];
let lydian = [2, 2, 2, 1, 2, 2, 1];
let mixolydian = [2, 2, 1, 2, 2, 1, 2];
let aolian = [2, 1, 2, 2, 1, 2, 2];
let locrian = [1, 2, 2, 1, 2, 2, 2];
let wholeTone = [2, 2, 2, 2, 2, 2];
let diminished = [2, 1, 2, 1, 2, 1, 2, 1];
let revDim = [1, 2, 1, 2, 1, 2, 1, 2];
let altered = [1, 2, 1, 2, 2, 2, 2];

let scales = [ionian, dorian, phrygian, lydian, mixolydian, aolian, locrian, wholeTone, diminished, revDim, altered]

var usingApp = true;

class Chord {
    var chordTone:String;
    var chordQuality:String;
    var soloNoteBank = [String]();
    var finalChord:String;
    var soloScale:[Int]!;
    var scaleSharpFlatNat:String;
    var solo = [String]();
    var soloLength:Int;

    //determine chord and matching scale name
    init(root: String, quality: String, length: Int) {
        chordTone = root;
        chordQuality = quality;
        finalChord = root + quality;
        soloLength = length * 8;
        switch (chordQuality) {
            case ("maj"): soloScale = ionian
            case ("maj7"): soloScale = ionian
            case ("maj6"): soloScale = ionian
            case ("min"): soloScale = [-1]
            case ("min7"): soloScale = [-1]
            case ("min6"): soloScale = dorian
            case ("maj7b5"): soloScale = lydian
            case ("7"): soloScale = [-1]
            case ("min7b5"): soloScale = locrian
            case ("dim"): soloScale = [-1]; scaleLengthLimit = 8
            case ("7b9"): soloScale = [-1]
            case ("7#9"): soloScale = [-1]
            case ("7b5"): soloScale = [-1]
            case ("7#5"): soloScale = [-1]
            default: soloScale = ionian
        }
        soloNoteBank = []
        scaleSharpFlatNat = "";
    }
    
    func specificSelector() {
        var choiceInput:String;
        if (chordQuality.contains("minor")){
            print("Select a further option: dorian (less happier/funkier) or aolian (sadder/more minor)?")
            choiceInput = readLine()!;
            switch (choiceInput) {
                case "dorian": soloScale = dorian
                case "aolian": soloScale = aolian
                default: soloScale = aolian
            }
        
        } else if (chordQuality.contains("7") && !chordQuality.contains("min")) {
            print("Select a further option: mixolydian (most resonant), whole tone (hip), or altered (hip with dissonance)?")
            choiceInput = readLine()!;
            switch (choiceInput) {
                case "mixolydian": soloScale = mixolydian
                case "whole tone": soloScale = wholeTone; scaleLengthLimit = 6
                case "altered": soloScale = altered
                default: soloScale = mixolydian
            }
        }
        else if (chordQuality.contains("dim")) {
            print("Select a further option: wholehalf or halfwhole?")
            choiceInput = readLine()!;
            switch (choiceInput) {
                case "wholehalf": soloScale = diminished
                case "halfwhole": soloScale = revDim
                default: soloScale = diminished
            }
        }
    }
    
    //determine sharps, flats, or nats; messy for now
    func determineSFN() {
        if (chordTone.contains("#")) {
            scaleSharpFlatNat = "#";
        } else if (chordTone.contains("b")) {
            scaleSharpFlatNat = "b";
            
        } else {
            if (chordTone == "A") {
                if (soloScale == ionian || soloScale == dorian || soloScale == lydian || soloScale == mixolydian || soloScale == wholeTone || soloScale == altered) {
                    scaleSharpFlatNat = "#";
                } else if (soloScale == phrygian || soloScale == locrian || soloScale == altered ) {
                    scaleSharpFlatNat = "b";
                }
                else {
                    scaleSharpFlatNat = "";
                }
                
            }
                
            else if (chordTone == "B") {
                if (soloScale == ionian || soloScale == dorian || soloScale == phrygian || soloScale == lydian || soloScale == mixolydian || soloScale == aolian || soloScale == wholeTone) {
                    scaleSharpFlatNat = "#";
                } else if (soloScale == altered) {
                    scaleSharpFlatNat = "b";
                }
                else {
                    scaleSharpFlatNat = "";
                }
            }
                
            else if (chordTone == "C") {
                if (soloScale == lydian || soloScale == altered) {
                    scaleSharpFlatNat = "#";
                } else if (soloScale == dorian || soloScale == phrygian || soloScale == mixolydian || soloScale == aolian || soloScale == locrian || soloScale == wholeTone) {
                    scaleSharpFlatNat = "b";
                } else {
                    scaleSharpFlatNat = "";
                }
            }
                
            else if (chordTone == "D") {
                if (soloScale == ionian || soloScale == lydian || soloScale == mixolydian || soloScale == wholeTone) {
                    scaleSharpFlatNat = "#";
                } else if (soloScale == phrygian || soloScale == aolian || soloScale == locrian || soloScale == wholeTone) {
                    scaleSharpFlatNat = "b";
                }
                else {
                    scaleSharpFlatNat = "";
                }
            }
                
            else if (chordTone == "E") {
                if (soloScale == ionian || soloScale == dorian || soloScale == lydian || soloScale == mixolydian || soloScale == aolian || soloScale == wholeTone) {
                    scaleSharpFlatNat = "#";
                } else if (soloScale == locrian || soloScale == altered) {
                    scaleSharpFlatNat = "b";
                }
                else {
                    scaleSharpFlatNat = "";
                }
            }
                
            else if (chordTone == "F") {
                if (soloScale == ionian || soloScale == dorian || soloScale == phrygian || soloScale == mixolydian || soloScale == aolian || soloScale == locrian || soloScale == altered) {
                    scaleSharpFlatNat = "b";
                } else if (soloScale == wholeTone) {
                    scaleSharpFlatNat = "#";
                }
                else {
                    scaleSharpFlatNat = "";
                }
            }
                
            else if (chordTone == "G") {
                if (soloScale == ionian || soloScale == lydian || soloScale == wholeTone) {
                    scaleSharpFlatNat = "#";
                } else if (soloScale == dorian || soloScale == phrygian || soloScale == aolian || soloScale == locrian || soloScale == altered) {
                    scaleSharpFlatNat = "b";
                } else {
                    scaleSharpFlatNat = "";
                }
            }
            else {
                scaleSharpFlatNat = "";
            }
        }
    }
    
    //find starting point in calculating scale
    func findStart() {
        if scaleSharpFlatNat == "#" {
            for notes in notesSharps {
                if chordTone == notes {
                    break;
                }
                startIndex += 1;
            }
        } else if scaleSharpFlatNat == "b" {
            for notes in notesFlats {
                if chordTone == notes {
                    break;
                }
                startIndex += 1;
            }
        } else {
            for notes in notesNats {
                if chordTone == notes {
                    break;
                }
                startIndex += 1;
            }
        }
    }
    
    //determine all possible notes from scale
    func determineNoteBankSharp() {
        var ctr3 = 0;
        while (ctr3 < scaleLengthLimit) {
            if (startIndex == 12) {
                startIndex = 0;
            }
            if (startIndex == 13) {
                startIndex = 1;
            }
            soloNoteBank.append(notesSharps[startIndex]);
            startIndex += soloScale[ctr3];
            ctr3 += 1;
        }
    }
    
    func determineNoteBankFlat() {
        var ctr3 = 0;
        while (ctr3 < scaleLengthLimit) {
            if (startIndex == 12) {
                startIndex = 0;
            }
            if (startIndex == 13) {
                startIndex = 1;
            }
            soloNoteBank.append(notesFlats[startIndex]);
            startIndex += soloScale[ctr3];
            ctr3 += 1;
        }
    }
    
    func determineNoteBankNat() {
        var ctr3 = 0;
        while (ctr3 < scaleLengthLimit) {
            if (startIndex == 7) {
                startIndex = 0;
            }
            soloNoteBank.append(notesNats[startIndex]);
            startIndex += 1;
            ctr3 += 1;
        }
    }
    
    //generate a random solo
    func generateSolo() {
        var ctr = 0;
        while (ctr < soloLength) {
            solo.append(soloNoteBank[Int(arc4random_uniform(UInt32(scaleLengthLimit)))]);
            ctr += 1;
        }
    }
    
    func printResults(){
        print("chord: ");
        print(finalChord);
        print("solo note bank: ");
        print(soloNoteBank);
        print("solo: ");
        print(solo);
    }
}

func keepUsing() {
    print("Enter another chord? (Y or N): ");
    let answer = readLine();
    if (answer == "Y" ) {
        usingApp = true;
    } else {
        usingApp = false;
    }
}

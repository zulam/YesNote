//
//  Music.swift
//  SoloBuilder
//
//  Created by Zack Ulam on 9/9/17.
//  Copyright © 2017 Zack Ulam. All rights reserved.
//

import Foundation

let notesFlats = ["Ab", "A", "Bb", "B", "C", "Db", "D", "Eb", "E", "F", "Gb", "G"];
let notesSharps = ["A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#"];
let notesNats = ["A", "B", "C", "D", "E", "F", "G"];
let allNotes = ["Ab", "A", "Bb", "B", "C", "Db", "D", "Eb", "E", "F", "Gb", "G", "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#"]

var startIndex = 0;

let indexLimit = 12;
let scaleLengthLimit = 7;
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

class Chord {
    var chordTone:String;
    var chordQuality:String;
    var soloNoteBank = [String]();
    var finalChord:String;
    var soloScale:[Int]!;
    var scaleSharpFlatNat:String;
    var solo = [String]();

    //determine chord and matching scale name
    init(root: String, quality: String) {
        chordTone = root;
        chordQuality = quality;
        finalChord = root + quality;
        switch (chordQuality) {
            case ("maj"): soloScale = ionian
            case ("maj7"): soloScale = ionian
            case ("maj6"): soloScale = ionian
            case ("min"): soloScale = dorian
            case ("min7"): soloScale = aolian
            case ("min6"): soloScale = dorian
            case ("maj7b5"): soloScale = lydian
            case ("7"): soloScale = mixolydian
            case ("min7b5"): soloScale = locrian
            case ("dim"): soloScale = diminished
            case ("7b9"): soloScale = altered
            case ("7#9"): soloScale = altered
            case ("7b5"): soloScale = wholeTone
            case ("7#5"): soloScale = wholeTone
            default: soloScale = ionian
        }
        soloNoteBank = []
        scaleSharpFlatNat = "";
    }
    
    //determine sharps, flats, or nats
    func determineSFN() {
        if (chordTone.contains("#")) {
            scaleSharpFlatNat = "#";
        } else if (chordTone.contains("b")) {
            scaleSharpFlatNat = "b";
            
        } else {
            if (chordTone == "A") {
                if (soloScale == ionian || soloScale == dorian || soloScale == lydian || soloScale == mixolydian) {
                    scaleSharpFlatNat = "#";
                } else if (soloScale == phrygian || soloScale == locrian || soloScale == mixolydian) {
                    scaleSharpFlatNat = "b";
                }
                else {
                    scaleSharpFlatNat = "";
                }
                
            }
                
            else if (chordTone == "B") {
                if (soloScale == ionian || soloScale == dorian || soloScale == phrygian || soloScale == lydian || soloScale == mixolydian || soloScale == aolian) {
                    scaleSharpFlatNat = "#";
                } else {
                    scaleSharpFlatNat = "";
                }
            }
                
            else if (chordTone == "C") {
                if (soloScale == lydian) {
                    scaleSharpFlatNat = "#";
                } else if (soloScale == dorian || soloScale == phrygian || soloScale == mixolydian || soloScale == aolian || soloScale == locrian) {
                    scaleSharpFlatNat = "b";
                } else {
                    scaleSharpFlatNat = "";
                }
            }
                
            else if (chordTone == "D") {
                if (soloScale == ionian || soloScale == lydian || soloScale == mixolydian) {
                    scaleSharpFlatNat = "#";
                } else if (soloScale == phrygian || soloScale == aolian || soloScale == locrian) {
                    scaleSharpFlatNat = "b";
                }
                else {
                    scaleSharpFlatNat = "";
                }
            }
                
            else if (chordTone == "E") {
                if (soloScale == ionian || soloScale == dorian || soloScale == lydian || soloScale == mixolydian || soloScale == aolian) {
                    scaleSharpFlatNat = "#";
                } else if (soloScale == locrian) {
                    scaleSharpFlatNat = "b";
                }
                else {
                    scaleSharpFlatNat = "";
                }
            }
                
            else if (chordTone == "F") {
                if (soloScale == ionian || soloScale == dorian || soloScale == phrygian || soloScale == mixolydian || soloScale == aolian || soloScale == locrian) {
                    scaleSharpFlatNat = "b";
                }
                else {
                    scaleSharpFlatNat = "";
                }
            }
                
            else if (chordTone == "G") {
                if (soloScale == ionian || soloScale == lydian) {
                    scaleSharpFlatNat = "#";
                } else if (soloScale == dorian || soloScale == phrygian || soloScale == aolian || soloScale == locrian) {
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
    
    func generateSolo() {
        var ctr = 0;
        while (ctr < scaleLengthLimit + 1) {
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

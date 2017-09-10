//
//  main.swift
//  SoloBuilder
//
//  Created by Zack Ulam on 9/5/17.
//  Copyright © 2017 Zack Ulam. All rights reserved.
//

import Foundation
import Darwin

var root: String;
var qual: String;

while usingApp {
    
    //enter chord info
    print("Enter the chord tone: ");
    root = readLine()!;

    print("Enter the chord Quality (maj, min, maj7, etc.) : ");
    qual = readLine()!;

    //initializing chord
    var myChord = Chord(root: root, quality: qual);

    //determining if scale pulls from sharps, flats, or nats
    myChord.determineSFN();

    //find starting index from scale
    myChord.findStart();

    //determining all notes in scale
    switch(myChord.scaleSharpFlatNat) {
        case "#": myChord.determineNoteBankSharp()
        case "b": myChord.determineNoteBankFlat()
        case "": myChord.determineNoteBankNat()
        default: myChord.determineNoteBankNat()
    }

    //random solo generator for chord
    myChord.generateSolo();

    //print results
    myChord.printResults();
    
    keepUsing();
}

























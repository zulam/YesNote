//
//  main.swift
//  SoloBuilder
//
//  Created by Zack Ulam on 9/5/17.
//  Copyright © 2017 Zack Ulam. All rights reserved.
//

while usingApp {
    //enter chord info
    print("Enter the chord tone: ");
    let root = readLine()!;

    print("Enter the chord Quality (maj, min, maj7, etc.) : ");
    let qual = readLine()!;
    
    print("Enter the number of measures (8 notes/measure): ");
    let length = Int(readLine()!);
    
    //initializing chord
    var myChord = Chord(root: root, quality: qual, length: length!);
    
    if (myChord.soloScale == [-1]) {
        myChord.specificSelector();
    }
    
    print(myChord.soloScale);

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


























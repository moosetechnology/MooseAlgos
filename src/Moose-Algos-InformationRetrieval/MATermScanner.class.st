"
TermScanner breaks an input stream into tokens. 

example: stream
	| scanner |
	scanner := TermScanner new.
	scanner onStream: stream.
	[ scanner atEnd ] 
		whileFalse: 
			[ scanner next ]		

Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MATermScanner,
	#superclass : #Object,
	#instVars : [
		'stream',
		'buffer',
		'term'
	],
	#classVars : [
		'Void'
	],
	#category : #'Moose-Algos-InformationRetrieval'
}

{ #category : #'instance creation' }
MATermScanner class >> new [
	
	^self basicNew initialize
]

{ #category : #running }
MATermScanner class >> scan: input [
	
	
	| scanner |
	scanner := (self new)
onStream: input readStream.
		
	^ scanner	allTerms.
]

{ #category : #running }
MATermScanner >> allTerms [
	
	
	| bag |
	
	bag := MATerms new.
	
	[self atEnd] whileFalse: [bag add: self next].
	
	^bag
]

{ #category : #scanning }
MATermScanner >> atEnd [
	
	
	term == Void ifTrue: [term := self privateNext].
	
	^term isNil
]

{ #category : #'initialize-release' }
MATermScanner >> initialize [
	
	buffer := String new writeStream
]

{ #category : #scanning }
MATermScanner >> next [
	
	^term == Void
		ifTrue: [self privateNext]
		ifFalse:
			[| result |
			result := term.
			term := Void.
			result]
]

{ #category : #running }
MATermScanner >> onFile: filename [
	
	self onStream: filename asFilename readStream
]

{ #category : #running }
MATermScanner >> onStream: input [
	
	stream := input.
	term := Void
]

{ #category : #running }
MATermScanner >> onString: text [
	
	self onStream: text readStream
]

{ #category : #private }
MATermScanner >> privateNext [
	
	
	| next |
	
	buffer reset.

	
	[
	[((next := stream informationRetrievalNext) isLetter) ] whileFalse.
	
	[buffer nextPut: next asLowercase.
	(next := stream informationRetrievalNext) isLetter] whileTrue.
	
	
	[((next := stream informationRetrievalNext) isLetter)  ] whileFalse.
	
	stream skip: -1.
	]
on: Stream endOfStreamSignal
	do:
[:ex | 
"-- do nothing"  
].
	
	^buffer contents isEmpty
	ifTrue: [nil]
ifFalse: [buffer contents]
]

{ #category : #accessing }
MATermScanner >> stream [
	
	^stream
]

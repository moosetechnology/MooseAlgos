"
CamelcaseScanner breaks an input stream into tokens, with respect to camel case.

Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MACamelcaseScanner,
	#superclass : #MATermScanner,
	#instVars : [
		'next'
	],
	#category : #'Moose-Algos-InformationRetrieval'
}

{ #category : #example }
MACamelcaseScanner class >> bible [
	
	^(self new)
		onFile: 'bible10.txt';
		allTerms
]

{ #category : #'initialize-release' }
MACamelcaseScanner >> onStream: input [
	
	
		super onStream: input.
	
		next := Character space
]

{ #category : #private }
MACamelcaseScanner >> privateNext [
	
	
		next isNil ifTrue: [^nil].
	
		buffer reset.
	
		[self xWhitespace.
	
			next isLowercase

			ifTrue: [self xLowercaseWord]
		
			ifFalse: [self xCapitalizedWord]]
on: Stream endOfStreamSignal	do: [:ex | next := nil].
	
		
		^buffer contents isEmpty
	ifTrue: [nil]
ifFalse: [buffer contents]
]

{ #category : #private }
MACamelcaseScanner >> xCapitalizedWord [
	
	
		buffer nextPut: next.
	
		next := stream informationRetrievalNext.
	
		next isLetter
ifTrue:
[
			next isLowercase
ifTrue:
[
				buffer collection
at: 1
put: buffer collection first asLowercase.
					
				self xLowercaseWord
			]
				
						ifFalse: [self xUppercaseWord]
		]
]

{ #category : #private }
MACamelcaseScanner >> xLowercaseWord [
	
	
	
	[buffer nextPut: next.
	
	next := stream informationRetrievalNext.
	
	next isLowercase] whileTrue
]

{ #category : #private }
MACamelcaseScanner >> xUppercaseWord [
	
	
	[| peek |
	
	peek := stream peek.
	
	next isLetter and: [peek == nil or: [peek isLowercase not]]]
	whileTrue:
	[buffer nextPut: next.
			next := stream informationRetrievalNext]
]

{ #category : #private }
MACamelcaseScanner >> xWhitespace [
	
	| previous |
	next isLetter
		ifFalse:
			[[previous := next.
			next := stream informationRetrievalNext.
			($0 == next and: [previous isSeparator]) ifTrue: [self xZeroWord].
			next isLetter] whileFalse]
]

{ #category : #private }
MACamelcaseScanner >> xZeroWord [
	
	[next isAlphaNumeric] whileTrue: [next := stream informationRetrievalNext]
]

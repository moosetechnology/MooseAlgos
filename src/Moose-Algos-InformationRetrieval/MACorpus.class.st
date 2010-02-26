"
Corpus maps document (which may be any kind of object) to Terms.
For convenience, there is special support for file documents.

Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MACorpus,
	#superclass : #Object,
	#instVars : [
		'documents'
	],
	#category : #'Moose-Algos-InformationRetrieval'
}

{ #category : #example }
MACorpus class >> deer90 [
	"(((	self deer90	)))"
	
	
	| data corpus |
	
	data := #(#(#c1 'Human machine interface for Lab ABC computer applications') #(#c2 'A survey of user opinion of computer system response time') #(#c3 'The EPS user interface management system') #(#c4 'System and human system engineering testing of EPS') #(#c5 'Relation of user-perceived response time to error measurement') #(#m1 'The generation of random, binary, unordered trees') #(#m2 'The intersection graph of paths in trees') #(#m3 'Graph minors IV: Widths of trees and well-quasi-ordering') #(#m4 'Graph minors: A survey')).

	
	corpus := MACorpus new.
	
	
	data
do:
[:each | 	corpus
addDocument: each first
with: (MATerms fromString: each last)].
	
	
	^corpus
]

{ #category : #'instance creation' }
MACorpus class >> new [
	
	^self basicNew initialize
]

{ #category : #adding }
MACorpus >> addDocument: anObject [
	
	
		documents
	at: anObject
	ifAbsentPut: [
			
					MATerms new]
]

{ #category : #adding }
MACorpus >> addDocument: anObject with: terms [
		
		self addDocument: anObject.
	
		self atDocument: anObject add: terms
]

{ #category : #adding }
MACorpus >> addDocument: aString withContent: contentString [
	
	self
		addDocument: aString
		with:
			((MATerms new)
				addString: contentString using: MACamelcaseScanner;
				yourself)
]

{ #category : #adding }
MACorpus >> addFile: aFilename [
	
	self
		addDocument: aFilename asString
		withContent: aFilename contentsOfEntireFile
]

{ #category : #adding }
MACorpus >> addFolder: aFoldername [
	
	aFoldername asFilename filesDo: [:each | self addFile: each]
]

{ #category : #adding }
MACorpus >> addSimpleDocument: aSimpleDocument [
	
	| terms |
	terms := MATerms new.
	aSimpleDocument termBag
		valuesAndCountsDo:
			[:value :count | terms add: value withOccurrences: count].
	self addDocument: aSimpleDocument with: terms
]

{ #category : #adding }
MACorpus >> atDocument: anObject [
	
	^documents at: anObject
]

{ #category : #adding }
MACorpus >> atDocument: anObject add: terms [
	
	(documents at: anObject) addAll: terms
]

{ #category : #enumerating }
MACorpus >> documentTermCountDo: aBlock [
	
	documents
		keysAndValuesDo:
			[:document :terms | 
			terms
				withCountDo:
					[:term :count | aBlock value: document value: term value: count]]
]

{ #category : #accessing }
MACorpus >> documents [
	
	^documents keys
]

{ #category : #'initialize-release' }
MACorpus >> initialize [
	
	documents := Dictionary new
]

{ #category : #removing }
MACorpus >> removeStopwords [
	
	
		documents do: [:each | each removeStopwords]
]

{ #category : #removing }
MACorpus >> stemAll [
	
	documents do: [:each | each stemAll]
]

{ #category : #accessing }
MACorpus >> terms [
	
	| all |
	all := MATerms new.
	documents do: [:each | all addAll: each].
	^all
]

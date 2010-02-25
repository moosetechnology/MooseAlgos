"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MACorpusTest,
	#superclass : #TestCase,
	#category : #'Moose-Algos-InformationRetrieval'
}

{ #category : #running }
MACorpusTest >> testDeer90 [
	
	| deer |
	deer := MACorpus deer90.
	self assert: deer documents size = 9.
	self assert: deer terms distinctSize = 42.
	^deer
]

{ #category : #running }
MACorpusTest >> testRemoveStopwords [
	
	| deer |
	deer := self testDeer90.
	self assert: (deer terms includes: 'the').
	deer removeStopwords.
	self assert: (deer terms includes: 'the') not.
	self assert: deer documents size = 9.
	self assert: deer terms distinctSize = 34.
	^deer
]

{ #category : #running }
MACorpusTest >> testStemDeer90 [
	
	| deer |
	deer := self testDeer90.
	self assert: (deer terms includes: 'trees').
	self assert: (deer terms includes: 'tree') not.
	deer stemAll.
	self assert: (deer terms includes: 'trees') not.
	self assert: (deer terms includes: 'tree').
	self assert: deer documents size = 9.
	self assert: deer terms distinctSize = 42.
	^deer
]

"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MATermsTest,
	#superclass : #TestCase,
	#type : #variable,
	#instVars : [
		'terms'
	],
	#category : #'Moose-Algos-InformationRetrieval'
}

{ #category : #running }
MATermsTest >> testAddFew [
	
	terms := MATerms fromString: 'and the super of a'.
	self assert: terms size = 5.
	self assert: terms distinctSize = 5.
	^terms
]

{ #category : #running }
MATermsTest >> testAddMany [
	
	terms := MATerms fromString: 'and the super of the a of the a'.
	self assert: terms size = 9.
	self assert: terms distinctSize = 5.
	^terms
]

{ #category : #running }
MATermsTest >> testCollect [
	
	| collection |
	terms := MATerms sample.
	collection := terms collect: [:each | each first].
	self
		assert:
			(collection
				equalsTo:
					'aaaaaaaabbbbbcccceefffffgiiiiiiiilllllmmmmmmnppppprrrssssssstttttttttttttttw'
						asBag).
	^collection
]

{ #category : #running }
MATermsTest >> testDistinctSize [
	
	terms := MATerms sample.
	self assert: terms distinctSize = 56.
	^terms
]

{ #category : #running }
MATermsTest >> testEmpty [
	
	terms := MATerms new.
	self assert: terms size = 0.
	self assert: terms distinctSize = 0.
	terms do: [:each | self assert: false]
]

{ #category : #running }
MATermsTest >> testEnumerate [
	
	terms := MATerms sample.
	terms do: [:each | self assert: each isString]
]

{ #category : #running }
MATermsTest >> testEnumerateValues [
	
	terms := MATerms sample.
	terms termsDo: [:each | self assert: each isString]
]

{ #category : #running }
MATermsTest >> testIncludesFalse [
	
	terms := MATerms sample.
	self assert: (terms includes: 'super') not.	"not there, but has bucket"
	self assert: (terms includes: '123456789abcdef') not.	"off bounds"
	self assert: (terms includes: '') not.	"off bounds"
	self assert: (terms includes: '123456789') not.	"neither there, nor bucket"
	self assert: (terms includes: nil) not.
	^terms
]

{ #category : #running }
MATermsTest >> testIncludesTrue [
	
	terms := MATerms sample.
	self assert: (terms includes: 'tree').
	self assert: (terms includes: 'a').	"first bucket"
	self assert: (terms includes: 'connectivity').	"last bucket"
	self assert: (terms includes: 'the').
	self assert: (terms includes: 'graph').
	^terms
]

{ #category : #running }
MATermsTest >> testNewColon [
	
	terms := MATerms new: 7.
	self assert: terms size = 0.
	^terms
]

{ #category : #running }
MATermsTest >> testOccurrencesOf [
	
	terms := MATerms sample.
	self assert: (terms occurrencesOf: 'tree') = 5.
	self assert: (terms occurrencesOf: 'a') = 6.
	self assert: (terms occurrencesOf: 'connectivity') = 1.
	self assert: (terms occurrencesOf: 'the') = 2.
	self assert: (terms occurrencesOf: 'graph') = 1.
	^terms
]

{ #category : #running }
MATermsTest >> testPrune [
	
	terms := MATerms sample.
	self assert: terms distinctSize = 56.
	self assert: terms size = 76.
	terms prune.
	self assert: terms distinctSize = 3.
	self assert: terms size = 9.
	^terms
]

{ #category : #running }
MATermsTest >> testRemoveHapaxes [
	
	terms := MATerms sample.
	self assert: terms distinctSize = 56.
	terms removeHapaxes.
	self assert: terms distinctSize = 12.
	^terms
]

{ #category : #running }
MATermsTest >> testRemoveStopwords [
	
	terms := MATerms sample.
	self assert: terms distinctSize = 56.
	terms removeStopwords.
	self assert: terms distinctSize = 24.
	^terms
]

{ #category : #running }
MATermsTest >> testSize [
	
	terms := MATerms sample.
	self assert: terms size = 76.
	^terms
]

{ #category : #running }
MATermsTest >> testStellAll [
	
	terms := MATerms sample.
	self assert: terms distinctSize = 56.
	self assert: terms size = 76.
	terms stemAll.
	self assert: terms distinctSize = 55.
	self assert: terms size = 76.
	^terms
]

{ #category : #running }
MATermsTest >> testTopTen [
	
	| charts |
	terms := MATerms sample.
	terms removeStopwords.
	charts := terms topTen.
	self assert: charts size = 10.
	self assert: charts first = 'tree'.
	self assert: charts second = 'paths'.
	self assert: charts third = 'root'.
	^terms
]

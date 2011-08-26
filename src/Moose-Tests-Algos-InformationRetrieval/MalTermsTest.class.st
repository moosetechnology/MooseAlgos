"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MalTermsTest,
	#superclass : #TestCase,
	#type : #variable,
	#instVars : [
		'terms'
	],
	#category : #'Moose-Tests-Algos-InformationRetrieval'
}

{ #category : #running }
MalTermsTest >> testAddFew [
	
	terms := MalTerms fromString: 'and the super of a'.
	self assert: terms size = 5.
	self assert: terms distinctSize = 5.
	^terms
]

{ #category : #running }
MalTermsTest >> testAddMany [
	
	terms := MalTerms fromString: 'and the super of the a of the a'.
	self assert: terms size = 9.
	self assert: terms distinctSize = 5.
	^terms
]

{ #category : #running }
MalTermsTest >> testCollect [
	
	| collection |
	terms := MalTerms sample.
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
MalTermsTest >> testDistinctSize [
	
	terms := MalTerms sample.
	self assert: terms distinctSize = 56.
	^terms
]

{ #category : #running }
MalTermsTest >> testEmpty [
	
	terms := MalTerms new.
	self assert: terms size = 0.
	self assert: terms distinctSize = 0.
	terms do: [:each | self assert: false]
]

{ #category : #running }
MalTermsTest >> testEnumerate [
	
	terms := MalTerms sample.
	terms do: [:each | self assert: each isString]
]

{ #category : #running }
MalTermsTest >> testEnumerateValues [
	
	terms := MalTerms sample.
	terms termsDo: [:each | self assert: each isString]
]

{ #category : #running }
MalTermsTest >> testIncludesFalse [
	
	terms := MalTerms sample.
	self assert: (terms includes: 'super') not.	"not there, but has bucket"
	self assert: (terms includes: '123456789abcdef') not.	"off bounds"
	self assert: (terms includes: '') not.	"off bounds"
	self assert: (terms includes: '123456789') not.	"neither there, nor bucket"
	self assert: (terms includes: nil) not.
	^terms
]

{ #category : #running }
MalTermsTest >> testIncludesTrue [
	
	terms := MalTerms sample.
	self assert: (terms includes: 'tree').
	self assert: (terms includes: 'a').	"first bucket"
	self assert: (terms includes: 'connectivity').	"last bucket"
	self assert: (terms includes: 'the').
	self assert: (terms includes: 'graph').
	^terms
]

{ #category : #running }
MalTermsTest >> testNewColon [
	
	terms := MalTerms new: 7.
	self assert: terms size = 0.
	^terms
]

{ #category : #running }
MalTermsTest >> testOccurrencesOf [
	
	terms := MalTerms sample.
	self assert: (terms occurrencesOf: 'tree') = 5.
	self assert: (terms occurrencesOf: 'a') = 6.
	self assert: (terms occurrencesOf: 'connectivity') = 1.
	self assert: (terms occurrencesOf: 'the') = 2.
	self assert: (terms occurrencesOf: 'graph') = 1.
	^terms
]

{ #category : #running }
MalTermsTest >> testPrune [
	
	terms := MalTerms sample.
	self assert: 56 equals: terms distinctSize.
	self assert: 76 equals: terms size.
	terms prune.
	self assert: 4 equals: terms distinctSize.
	self assert: 11 equals: terms size.
	^terms
]

{ #category : #running }
MalTermsTest >> testRemoveHapaxes [
	
	terms := MalTerms sample.
	self assert: terms distinctSize = 56.
	terms removeHapaxes.
	self assert: terms distinctSize = 12.
	^terms
]

{ #category : #running }
MalTermsTest >> testRemoveStopwords [
	
	terms := MalTerms sample.
	self assert: terms distinctSize = 56.
	terms removeStopwords.
	self assert: terms distinctSize = 24.
	^terms
]

{ #category : #running }
MalTermsTest >> testSize [
	
	terms := MalTerms sample.
	self assert: terms size = 76.
	^terms
]

{ #category : #running }
MalTermsTest >> testStellAll [
	
	terms := MalTerms sample.
	self assert: terms distinctSize = 56.
	self assert: terms size = 76.
	terms stemAll.
	self assert: terms distinctSize = 55.
	self assert: terms size = 76.
	^terms
]

{ #category : #running }
MalTermsTest >> testTopTen [
	
	| charts |
	terms := MalTerms sample.
	terms removeStopwords.
	charts := terms topTen.
	self assert: charts size = 10.
	self assert: charts first = 'tree'.
	self assert: ((charts copyFrom: 2 to: 3) includesAll: {'paths'. 'root'}).
	^terms
]

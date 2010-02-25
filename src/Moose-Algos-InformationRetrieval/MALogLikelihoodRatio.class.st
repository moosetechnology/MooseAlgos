"
Compares term bags.

Copyright (c), 2009 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.


"
Class {
	#name : #MALogLikelihoodRatio,
	#superclass : #Object,
	#instVars : [
		'terms1',
		'terms2'
	],
	#category : #'Moose-Algos-InformationRetrieval'
}

{ #category : #'instance creation' }
MALogLikelihoodRatio class >> with: terms1 and: terms2 [
	
	^(self new)
		setTerms1: terms1;
		setTerms2: terms2;
		yourself
]

{ #category : #accessing }
MALogLikelihoodRatio >> bottom: ten [
	
	^self computeAll last: ten
]

{ #category : #accessing }
MALogLikelihoodRatio >> bottomTen [
	
	^self bottom: 10
]

{ #category : #accessing }
MALogLikelihoodRatio >> computeAll [
	
	| comparison |
	comparison := (terms1 asSet union: terms2 asSet) asArray
		collect: [:each | each -> (self computeLogLR: each)].
	^(comparison sorted: #value asSortBlock) reversed
]

{ #category : #accessing }
MALogLikelihoodRatio >> computeAllOfTerms1 [
	
	| comparison |
	comparison := terms1 asSet asArray
		collect: [:each | each -> (self computeLogLR: each)].
	^(comparison sorted: #value asSortBlock) reversed
]

{ #category : #computing }
MALogLikelihoodRatio >> computeLogLR: aString [
	
	| k1 k2 n1 n2 p1 p2 p |
	k1 := terms1 occurrencesOf: aString.
	k2 := terms2 occurrencesOf: aString.
	n1 := terms1 fastSize.
	n2 := terms2 fastSize.
	p1 := k1 / n1 asDouble.
	p2 := k2 / n2 asDouble.
	p := (k1 + k2) / (n1 + n2) asDouble.
	^(p1 - p2) sign * 2
		*
			((self logL: p1 and: k1 and: n1) + (self logL: p2 and: k2 and: n2)
				- (self logL: p and: k1 and: n1) - (self logL: p and: k2 and: n2))
]

{ #category : #computing }
MALogLikelihoodRatio >> logL: p and: k and: n [
	
	^0 = k
		ifTrue: [0]
		ifFalse:
			[k * p ln
				+
					(0 = (n - k)
						ifTrue: [0]
						ifFalse: [(n - k) * (1 - p) ln])]
]

{ #category : #'initialize-release' }
MALogLikelihoodRatio >> setTerms1: aHapaxTerms [
	
	terms1 := aHapaxTerms
]

{ #category : #'initialize-release' }
MALogLikelihoodRatio >> setTerms2: aHapaxTerms [
	
	terms2 := aHapaxTerms
]

{ #category : #accessing }
MALogLikelihoodRatio >> terms1 [
	
	^terms1
]

{ #category : #accessing }
MALogLikelihoodRatio >> terms2 [
	
	^terms2
]

{ #category : #accessing }
MALogLikelihoodRatio >> top: ten [
	
	^self computeAll first: ten
]

{ #category : #accessing }
MALogLikelihoodRatio >> topTen [
	
	^self top: 10
]

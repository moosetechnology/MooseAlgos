"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MANameMapping,
	#superclass : #MAMapping,
	#instVars : [
		'names',
		'comparisonBlock'
	],
	#category : #'Moose-Algos-LinearAlgebra'
}

{ #category : #'instance creation' }
MANameMapping class >> new [
	
	^(super new)
		initialize;
		forEquality;
		yourself
]

{ #category : #'instance creation' }
MANameMapping class >> newUsing: aComparisonBlock [
	
	^(super new)
		initialize;
		setComparisonBlock: aComparisonBlock;
		yourself
]

{ #category : #adding }
MANameMapping >> add: name [
	
	(self includesName: name) ifTrue: [Error raise].
	names addLast: name.
	^self size
]

{ #category : #accessing }
MANameMapping >> atKey: key ifAbsent: exceptionBlock [
	
	^(key
		between: 1
		and: self size)
		ifTrue: [key]
		ifFalse: [exceptionBlock value]
]

{ #category : #enumerating }
MANameMapping >> do: aBlock [
	
	1
		to: self size
		do: [:each | aBlock value: each]
]

{ #category : #'initialize-release' }
MANameMapping >> forEquality [
	
	self setComparisonBlock: [:a :b | a = b]
]

{ #category : #'initialize-release' }
MANameMapping >> forIdentity [
	
	self setComparisonBlock: [:a :b | a == b]
]

{ #category : #testing }
MANameMapping >> includesName: name [
	
	^names contains: [:each | comparisonBlock value: each value: name]
]

{ #category : #'initialize-release' }
MANameMapping >> initialize [
	
	names := OrderedCollection new
]

{ #category : #'accessing - name' }
MANameMapping >> keyForName: name ifAbsent: exceptionBlock [
	
	^name isInteger
		ifTrue: [name]
		ifFalse:
			[names
				findFirst: [:each | comparisonBlock value: name value: each]
				ifAbsent: [exceptionBlock value]]
]

{ #category : #accessing }
MANameMapping >> keyOf: anIndex ifAbsent: exceptionBlock [
	
	^self atKey: anIndex ifAbsent: exceptionBlock
]

{ #category : #'accessing - name' }
MANameMapping >> keys [
	
	^names
]

{ #category : #'accessing - name' }
MANameMapping >> nameForKey: key [
	
	^names at: key
]

{ #category : #'accessing - name' }
MANameMapping >> names [
	
	^names
]

{ #category : #'initialize-release' }
MANameMapping >> setComparisonBlock: aComparisonBlock [
	
	^comparisonBlock := aComparisonBlock
]

{ #category : #accessing }
MANameMapping >> size [
	
	^names size
]

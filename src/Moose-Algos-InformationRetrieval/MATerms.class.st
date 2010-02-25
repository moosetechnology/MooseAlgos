"
Terms subclasses Bag with support for handling stopwords etc.

example: string
	| terms |
	terms := Terms new.
	terms addString: string using: CamelCaseScanner new.
	terms withCoundDo: [ :term :count |
		term -> count ].

Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MATerms,
	#superclass : #Bag,
	#instVars : [
		'size'
	],
	#category : #'Moose-Algos-InformationRetrieval'
}

{ #category : #examples }
MATerms class >> bible [
	
	^(MATermScanner new)
		onFile: 'bible10.txt';
		allTerms
]

{ #category : #'instance creation' }
MATerms class >> fromCamelcaseString: aString [
	
	^((MACamelcaseScanner new onString: aString) allTerms)
		stemAll;
		removeStopwords
]

{ #category : #'instance creation' }
MATerms class >> fromFile: aFile [
	
	^(MATermScanner new)
		onFile: aFile;
		allTerms
]

{ #category : #'instance creation' }
MATerms class >> fromString: aString [
	
	^(MATermScanner new)
		onString: aString;
		allTerms
]

{ #category : #examples }
MATerms class >> sample [
	
	^self fromString:
			'I think that I shall never see
		a graph more lovely than a tree.
		A tree whose crucial property
		is loop-free connectivity.
		A tree that must be sure to span
		so packet can reach every LAN.
		First, the root must be selected.
		By ID, it is elected.
		Least-cost paths from root are traced.
		In the tree, these paths are placed.
		A mesh is made by folks like me,
		then bridges find a spanning tree.'
]

{ #category : #examples }
MATerms class >> termCloud [
	
	^self bible prune showTermCloud
]

{ #category : #adding }
MATerms >> addString: string [
	
	^self addString: string using: MATermScanner
]

{ #category : #adding }
MATerms >> addString: string using: scannerClass [
	
	| scanner |
	scanner := scannerClass new.
	scanner onString: string.
	[scanner atEnd] whileFalse: [self add: scanner next]
]

{ #category : #adding }
MATerms >> addTerms: aTerms [
	
	aTerms withCountDo: [:each :count | self add: each withOccurrences: count]
]

{ #category : #accessing }
MATerms >> distinctSize [
	
	^contents associations size
]

{ #category : #accessing }
MATerms >> fastSize [
	
	^size ifNil: [size := super size]
]

{ #category : #converting }
MATerms >> normalized [
	
	| newTerms sum length |
	newTerms := MATerms new: contents size.
	sum := 0.
	contents do: [:count | sum := sum + (count * count)].
	length := sum sqrt.
	self
		withCountDo:
			[:each :count | 
			newTerms
				add: each
				withOccurrences: count asFloat / length].
	^newTerms
]

{ #category : #removing }
MATerms >> prune [
	
	self removeStopwords.
	self removeHapaxes.
	self stemAll
]

{ #category : #removing }
MATerms >> removeHapaxes [
	
	self removeRareTerms: 1
]

{ #category : #removing }
MATerms >> removeRareTerms: occurrence [
	
	| newTerms |
	newTerms := MATerms new: contents capacity.
	self
		withCountDo:
			[:term :count | 
			count > occurrence
				ifTrue:
					[newTerms
						add: (MAStemmer stem: term 
	)					withOccurrences: count]].
	self become: newTerms
]

{ #category : #removing }
MATerms >> removeStopwords [
	
	^self removeStopwords: English
]

{ #category : #removing }
MATerms >> removeStopwords: stopwords [
	
	stopwords do: [:each | contents removeKey: each ifAbsent: nil]
]

{ #category : #'Mondrian visuals' }
MATerms >> showTermCloud [
	
	| box counts min span |
	counts := self sortedCounts first: 100.
	counts sort: #key.
	counts do: [:each | each value: each value sqrt].
	min := counts minValue: #value.
	span := (counts maxValue: #value) - min.
	counts do: [:each | each value: (each value - min) / span * 48 + 16].
	box := LayoutBox new.
	counts
		do:
			[:each | 
			box
				add:
					((LabelFigure with: each value)
						label: each key
						size: each value)].
	box textLayout: 7 width: 800.
	box open	"	Terms bible prune showTermCloud	"
]

{ #category : #removing }
MATerms >> stemAll [
	
	| newTerms |
	newTerms := MATerms new: contents capacity.
	self
		withCountDo:
			[:term :count | 
			newTerms
				add: (MAStemmer stem: term) 
				withOccurrences: count].
	self become: newTerms
]

{ #category : #enumerating }
MATerms >> termsDo: aBlock [
	
	contents associationsDo: [:each | aBlock value: each key]	"!!! value -> count !!!"
]

{ #category : #converting }
MATerms >> top: topTenSize [
	
	^(self sortedCounts first: topTenSize) collect: #key
]

{ #category : #converting }
MATerms >> topTen [
	
	^(self sortedCounts first: 10) collect: #value
]

{ #category : #enumerating }
MATerms >> withCountDo: aBlock [
	
	contents
		associationsDo:
			[:each | 
			aBlock
				value: each key
				value: each value]
]

"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MOClusteringData,
	#superclass : #MASymetricMatrix,
	#instVars : [
		'indices',
		'value',
		'clusters',
		'foundA0',
		'foundB0'
	],
	#category : #'Moose-Algos-Clustering'
}

{ #category : #'instance creation' }
MOClusteringData class >> onDistanceSquare: distanceSquare [
	
	^(self basicNew)
		initialize: distanceSquare;
		yourself
]

{ #category : #private }
MOClusteringData class >> vectorSpecies [
	
	^Array
]

{ #category : #'linkage functions' }
MOClusteringData >> averageLinkage [
	
	| weightA weightB sizeA sizeB |
	sizeA := (clusters at: foundA0) size "asDouble"asFloat.
	sizeB := (clusters at: foundB0) size "asDouble"asFloat.
	weightA := sizeA / (sizeA + sizeB).
	weightB := sizeB / (sizeA + sizeB).
	self
		privateLinkage:
			[:index0 :valueA :valueB | valueA * weightA + (valueB * weightB)]
]

{ #category : #'linkage functions' }
MOClusteringData >> centroid [
	
	| weightA weightB sizeA sizeB valueC |
	sizeA := (clusters at: foundA0) size asFloat.
	sizeB := (clusters at: foundB0) size asFloat.
	weightA := sizeA / (sizeA + sizeB).
	weightB := sizeB / (sizeA + sizeB).
	valueC := (self at: foundA0 and: foundB0)
		- (sizeA * sizeB / (sizeA + sizeB) squared).
	self
		privateLinkage:
			[:index0 :valueA :valueB | valueA * weightA + (valueB * weightB) - valueC]
]

{ #category : #'linkage functions' }
MOClusteringData >> completeLinkage [
	
	self privateLinkage: [:index0 :valueA :valueB | valueA max: valueB]
]

{ #category : #accessing }
MOClusteringData >> dendrogram [
	
	[indices size = 1] assert.
	^clusters at: indices first
]

{ #category : #private }
MOClusteringData >> findMinimum [
	"This method is written such that it uses primitives only."
	
	| columnVector |
	value := Unlimited positive.
	2
		to: indices size
		do:
			[:column | 
			columnVector := partialColumns at: (indices at: column).
			columnVector min < value
				ifTrue:
					[value := columnVector min.
					foundB0 := indices at: column.
					foundA0 := columnVector found]]
]

{ #category : #'initialize-release' }
MOClusteringData >> initialize: distanceMatrix [
	
	partialColumns := distanceMatrix copyClusteringData
		collect: [:each | MOClusteringVector withAll: each].
	value := foundA0 := foundB0 := nil.
	clusters := distanceMatrix items
		collect: [:item | MODendrogram with: item].
	indices := (1 to: partialColumns size) asArray.
	1
		to: partialColumns size
		do: [:n | (partialColumns at: n) unsetAt: n]
]

{ #category : #'initialize-release' }
MOClusteringData >> initializeRows: m columns: n [
	
	^self shouldNotImplement
]

{ #category : #'linkage functions' }
MOClusteringData >> meanLinkage [
	
	self privateLinkage: [:index0 :valueA :valueB | (valueA + valueB) / 2]
]

{ #category : #clustering }
MOClusteringData >> performClustering: linkageSelector [
	
	indices size - 1
		timesRepeat:
			["IncrementNotification signalWith: indices size."
			self findMinimum.
			self perform: linkageSelector].
	^self dendrogram
]

{ #category : #private }
MOClusteringData >> privateLinkage: aBlock [
	
	indices := indices copyRemoveAtIndex: (indices indexOf: foundB0).
	indices
		do:
			[:index0 | 
			index0 = foundA0
				ifFalse:
					[self
						at: foundA0
						and: index0
						put:
							(aBlock
								value: index0
								value: (self at: foundA0 and: index0)
								value: (self at: foundB0 and: index0))].
			self unsetAt: foundB0 and: index0].
	clusters
		at: foundA0
		put:
			((clusters at: foundA0)
				merge: (clusters at: foundB0)
				at: value).
	clusters at: foundB0 put: nil
]

{ #category : #'linkage functions' }
MOClusteringData >> singleLinkage [
	
	self privateLinkage: [:index0 :valueA :valueB | valueA min: valueB]
]

{ #category : #private }
MOClusteringData >> testFindMinimum [
	| pValue pFoundA0 pFoundB0 column0 temp row0 |
	self findMinimum.
	pValue := value.
	pFoundA0 := foundA0.
	pFoundB0 := foundB0.
	value := Unlimited positive.

	2
to: indices size
do:
[:column | 
			
		column0 := indices at: column.
	
		1
to: column - 1
do:
[:row | 

			temp := (partialColumns at: column0) at: (row0 := indices at: row).
			temp < value
ifTrue:
[value := temp.
foundA0 := row0.
foundB0 := column0]]
	].
	[pValue = value & pFoundA0 = foundA0 & pFoundB0 = foundB0] assert.

	value := pValue.
	foundA0 := pFoundA0.
	foundB0 := pFoundB0
]

{ #category : #private }
MOClusteringData >> testPerformClustering: linkageSelector [
	
	indices size - 1
		timesRepeat:
			[IncrementNotification signal"With: indices size".
			self testFindMinimum.
			self perform: linkageSelector].
	^self dendrogram
]

{ #category : #private }
MOClusteringData >> unsetAt: row and: column [
	
	^row < column
		ifTrue: [(partialColumns at: column) unsetAt: row]
		ifFalse: [(partialColumns at: row) unsetAt: column]
]

{ #category : #'linkage functions' }
MOClusteringData >> wardsMethod [
	
	| sizeA sizeB valueC sizeC weightA weightB weightC |
	sizeA := (clusters at: foundA0) size asFloat.
	sizeB := (clusters at: foundB0) size asFloat.
	valueC := self at: foundA0 and: foundB0.
	self
		privateLinkage:
			[:index0 :valueA :valueB | 
			sizeC := (clusters at: index0) size.
			weightA := (sizeA + sizeC) / (sizeA + sizeB + sizeC).
			weightB := (sizeB + sizeC) / (sizeA + sizeB + sizeC).
			weightC := sizeC / (sizeA + sizeB + sizeC).
			valueA * weightA + (valueB * weightB) - (valueC * weightC)]
]

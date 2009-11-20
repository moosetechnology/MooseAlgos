"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MOCorrelationSquare,
	#superclass : #MODistanceSquare,
	#category : #'Moose-Algos-Clustering'
}

{ #category : #constants }
MOCorrelationSquare class >> defaultDistanceBlock [
	
	^[:a :b | a similarity: b]
]

{ #category : #private }
MOCorrelationSquare class >> vectorSpecies [
	
	^MOCorrelationVector
]

{ #category : #converting }
MOCorrelationSquare >> asImage [
	
	| image |
	image := Image
		extent: self dimension transpose
		depth: 32
		palette: FixedPalette rgb8Bit.
	1
		to: self columnSize
		do:
			[:column | 
			1
				to: self rowSize
				do:
					[:row | 
					| cosine temp |
					cosine := self at: row and: column.
					temp := cosine.
					temp := (temp max: 0) min: 1.
					temp := temp * temp.
					temp := temp < 0.1
						ifTrue: [0]
						ifFalse: [temp].
					temp := (255 - (temp * 255)) asInteger.
					temp := (temp bitOr: (temp bitShift: 8)) bitOr: (temp bitShift: 16).
					image
						atX: column - 1
						y: row - 1
						put: temp]].
	^image
]

{ #category : #private }
MOCorrelationSquare >> copyClusteringData [
	
	^partialColumns collect: [:each | each negated]
]

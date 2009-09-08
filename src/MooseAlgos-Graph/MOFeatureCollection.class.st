"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MOFeatureCollection,
	#superclass : #OrderedCollection,
	#type : #variable,
	#instVars : [
		'item'
	],
	#category : #'MooseAlgos-Clustering'
}

{ #category : #'instance creation' }
MOFeatureCollection class >> item: anItem features: aCollection [
	
	^((self withAll: aCollection) sorted)
		setItem: anItem;
		yourself
]

{ #category : #distance }
MOFeatureCollection >> chroniaHausdorffDistance: aFeatureCollection [
	"Answer a modified hausdorff distance between myself and aFeatureCollection. 
	Further information see 'How Developers Drive Software Evolution' (to be published at IWPSE 2005).
	Limitations of the implementation see FeatureCollection>>hausdorffMinima:."
	
	| distance |
	distance := MOAccumulator squaredSum.
	distance enumerate: (self hausdorffMinima: aFeatureCollection).
	distance enumerate: (aFeatureCollection hausdorffMinima: self).
	^distance value
]

{ #category : #distance }
MOFeatureCollection >> dist: aFeatureCollection [
	
	^self hausdorffDistance: aFeatureCollection
]

{ #category : #distance }
MOFeatureCollection >> hausdorffDistance: aFeatureCollection [
	"Answer the hausdorff distance between myself and aFeatureCollection. 
	Limitations of the implementation see FeatureCollection>>hausdorffMinima:."
	
	| distance |
	distance := MOAccumulator maximum.
	distance enumerate: (self hausdorffMinima: aFeatureCollection).
	distance enumerate: (aFeatureCollection hausdorffMinima: self).
	^distance value
]

{ #category : #private }
MOFeatureCollection >> hausdorffMinima: aFeatureCollection [
	"Answer for each element in myself the distance to the nearest element in aFeatureCollection.
	Assumes that the elements of both collections are sorted using an ordering that is compatible
	with the distance metric defined between these elements. Thus this implementation works fine
	with any arithemtic values, except points and complex numbers."
	
	| minima current stream |
	stream := aFeatureCollection readStream.
	current := stream next.
	minima := self
		collect:
			[:a | 
			[stream atEnd not and: [(current dist: a) >= (stream peek dist: a)]]
				whileTrue: [current := stream next].
			current dist: a].
	^minima
]

{ #category : #accessing }
MOFeatureCollection >> item [
	
	^item
]

{ #category : #accessing }
MOFeatureCollection >> setItem: anObject [
	
	item := anObject
]

{ #category : #distance }
MOFeatureCollection >> sizeDistance: aFeatureCollection [
	
	^self size dist: aFeatureCollection size
]

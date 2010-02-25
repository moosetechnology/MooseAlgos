"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MOVectorItem,
	#superclass : #MAVectorDecorator,
	#instVars : [
		'item'
	],
	#category : #'Moose-Algos-Clustering'
}

{ #category : #'instance creation' }
MOVectorItem class >> with: anElement and: aVector [
	
	^(self on: aVector)
		item: anElement;
		yourself
]

{ #category : #'instance creation' }
MOVectorItem class >> with: anElement andAll: aCollection [
	
	^(self on: (MAArrayVector withAll: aCollection))
		item: anElement;
		yourself
]

{ #category : #accessing }
MOVectorItem >> = anObject [
	
	^super = anObject
		or: [(anObject isKindOf: MOVectorItem) and: [self item = anObject item]]
]

{ #category : #'distance functions' }
MOVectorItem >> dist: anItem [
	
	^self vector dist: anItem vector
]

{ #category : #accessing }
MOVectorItem >> item [
	
	^item
]

{ #category : #accessing }
MOVectorItem >> item: anObject [
	
	item := anObject
]

{ #category : #printing }
MOVectorItem >> printOn: aStream [
	
	item printOn: aStream
]

{ #category : #accessing }
MOVectorItem >> vector [
	
	^vector
]

{ #category : #accessing }
MOVectorItem >> vector: anObject [
	
	vector := anObject
]

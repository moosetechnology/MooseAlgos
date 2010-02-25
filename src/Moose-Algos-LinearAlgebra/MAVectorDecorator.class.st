"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MAVectorDecorator,
	#superclass : #MAVector,
	#instVars : [
		'vector'
	],
	#category : #'Moose-Algos-LinearAlgebra'
}

{ #category : #'instance creation' }
MAVectorDecorator class >> on: aVector [
	
	^(self basicNew)
		setVector: aVector asVector;
		yourself
]

{ #category : #accessing }
MAVectorDecorator >> at: index [
	
	^vector at: index
]

{ #category : #accessing }
MAVectorDecorator >> at: index put: aNumber [
	
	^vector at: index put: aNumber
]

{ #category : #'initialize-release' }
MAVectorDecorator >> initializeSize: aSize [
	
	^self shouldNotImplement
]

{ #category : #'initialize-release' }
MAVectorDecorator >> setVector: aVector [
	
	^vector := aVector
]

{ #category : #accessing }
MAVectorDecorator >> size [
	
	^vector size
]

{ #category : #private }
MAVectorDecorator >> species [
	
	^vector species
]

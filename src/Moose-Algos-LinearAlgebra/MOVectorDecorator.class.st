"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MOVectorDecorator,
	#superclass : #MOVector,
	#instVars : [
		'vector'
	],
	#category : #'Moose-Algos-LinearAlgebra'
}

{ #category : #'instance creation' }
MOVectorDecorator class >> on: aVector [
	
	^(self basicNew)
		setVector: aVector asVector;
		yourself
]

{ #category : #accessing }
MOVectorDecorator >> at: index [
	
	^vector at: index
]

{ #category : #accessing }
MOVectorDecorator >> at: index put: aNumber [
	
	^vector at: index put: aNumber
]

{ #category : #'initialize-release' }
MOVectorDecorator >> initializeSize: aSize [
	
	^self shouldNotImplement
]

{ #category : #'initialize-release' }
MOVectorDecorator >> setVector: aVector [
	
	^vector := aVector
]

{ #category : #accessing }
MOVectorDecorator >> size [
	
	^vector size
]

{ #category : #private }
MOVectorDecorator >> species [
	
	^vector species
]

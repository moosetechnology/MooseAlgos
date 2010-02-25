"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MAMappedVector,
	#superclass : #MAVectorDecorator,
	#instVars : [
		'indices'
	],
	#category : #'Moose-Algos-LinearAlgebra'
}

{ #category : #'instance creation' }
MAMappedVector class >> on: aVector [
	
	^self on: aVector indices: nil
]

{ #category : #'instance creation' }
MAMappedVector class >> on: aVector indices: aReindexing [
	
	^(super on: aVector)
		setIndices: aReindexing;
		yourself
]

{ #category : #accessing }
MAMappedVector >> at: anIndex [
	
	^vector at: (indices at: anIndex)
]

{ #category : #accessing }
MAMappedVector >> at: anIndex put: aNumber [
	
	^vector
		at: (indices at: anIndex)
		put: aNumber
]

{ #category : #'initialize-release' }
MAMappedVector >> setIndices: aReindexing [
	
	indices := aReindexing ifNil: [MANumberMapping new: vector size]
]

{ #category : #accessing }
MAMappedVector >> size [
	
	^indices size
]

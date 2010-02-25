"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MAFloatVectorTest,
	#superclass : #MAVectorTest,
	#category : #'Moose-Algos-LinearAlgebra'
}

{ #category : #fixture }
MAFloatVectorTest >> testQuotient [
	
	^true	"the notorious equality problem with floats"
]

{ #category : #test }
MAFloatVectorTest >> testStoreDenseTextOn [
	
	^true	"when comparing text 0 is not 0.0"
]

{ #category : #fixture }
MAFloatVectorTest >> vectorClass [
	
	^MAFloatVector
]

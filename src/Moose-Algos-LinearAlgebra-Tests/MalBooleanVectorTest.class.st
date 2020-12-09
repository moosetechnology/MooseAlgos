"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MalBooleanVectorTest,
	#superclass : #TestCase,
	#instVars : [
		'v'
	],
	#category : #'Moose-Algos-LinearAlgebra-Tests'
}

{ #category : #tests }
MalBooleanVectorTest >> testAccessingLarge [
	v := MalBooleanVector new: 100.
	v at: 83 put: true.
	self assert: v size equals: 100.
	self assert: (v at: 82) not.
	self assert: (v at: 83).
	self assert: (v at: 84) not.
	v at: 83 put: false.
	self assert: (v allSatisfy: #not)
]

{ #category : #tests }
MalBooleanVectorTest >> testAccessingSmall [
	v := MalBooleanVector new: 5.
	v at: 3 put: true.
	self assert: v size equals: 5.
	self assert: (v at: 2) not.
	self assert: (v at: 3).
	self assert: (v at: 4) not.
	v at: 3 put: false.
	self assert: (v allSatisfy: #not)
]

{ #category : #tests }
MalBooleanVectorTest >> testAnd [
	| w vw |
	v := MalBooleanVector withAll: #(false false true true false false true true).
	w := MalBooleanVector withAll: #(false true false true true false true false).
	vw := v & w.
	self assert: vw size equals: 8.
	self assert: vw asArray equals: #(false false false true false false true false)
]

{ #category : #tests }
MalBooleanVectorTest >> testNew [
	v := MalBooleanVector new.
	self assert: v size equals: 0
]

{ #category : #tests }
MalBooleanVectorTest >> testNewLarge [
	v := MalBooleanVector new: 100.
	self assert: v size equals: 100.
	self assert: (v allSatisfy: #not)
]

{ #category : #tests }
MalBooleanVectorTest >> testNewSmall [
	v := MalBooleanVector new: 5.
	self assert: v size equals: 5.
	self assert: (v allSatisfy: #not)
]

{ #category : #tests }
MalBooleanVectorTest >> testNewWithAll [
	v := MalBooleanVector new: 100 withAll: true.
	self assert: v size equals: 100.
	self assert: (v allSatisfy: #yourself)
]

{ #category : #tests }
MalBooleanVectorTest >> testNot [
	v := MalBooleanVector withAll: #(false false true true false false true true).
	self assert: v not size equals: 8.
	self assert: v not asArray equals: #(true true false false true true false false)
]

{ #category : #tests }
MalBooleanVectorTest >> testOr [
	| w vw |
	v := MalBooleanVector withAll: #(false false true true false false true true).
	w := MalBooleanVector withAll: #(false true false true true false true false).
	vw := v | w.
	self assert: vw size equals: 8.
	self assert: vw asArray equals: #(false true true true true false true true)
]

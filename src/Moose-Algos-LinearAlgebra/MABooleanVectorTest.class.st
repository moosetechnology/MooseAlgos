"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MABooleanVectorTest,
	#superclass : #TestCase,
	#instVars : [
		'v'
	],
	#category : #'Moose-Algos-LinearAlgebra'
}

{ #category : #running }
MABooleanVectorTest >> testAccessingLarge [
	
	v := MABooleanVector new: 100.
	v at: 83 put: true.
	self assert: v size = 100.
	self assert: (v at: 82) not.
	self assert: (v at: 83).
	self assert: (v at: 84) not.
	v at: 83 put: false.
	self assert: (v allSatisfy: #not)
]

{ #category : #running }
MABooleanVectorTest >> testAccessingSmall [
	
	v := MABooleanVector new: 5.
	v at: 3 put: true.
	self assert: v size = 5.
	self assert: (v at: 2) not.
	self assert: (v at: 3).
	self assert: (v at: 4) not.
	v at: 3 put: false.
	self assert: (v allSatisfy: #not)
]

{ #category : #running }
MABooleanVectorTest >> testAnd [
	
	| w vw |
	v := MABooleanVector withAll:
			#(false false true true false false true true).
	w := MABooleanVector withAll:
			#(false true false true true false true false).
	vw := v & w.
	self assert: vw size = 8.
	self assert: vw asArray = #(false false false true false false true false)
]

{ #category : #running }
MABooleanVectorTest >> testNew [
	
	v := MABooleanVector new.
	self assert: v size = 0
]

{ #category : #running }
MABooleanVectorTest >> testNewLarge [
	
	v := MABooleanVector new: 100.
	self assert: v size = 100.
	self assert: (v allSatisfy: #not)
]

{ #category : #running }
MABooleanVectorTest >> testNewSmall [
	
	v := MABooleanVector new: 5.
	self assert: v size = 5.
	self assert: (v allSatisfy: #not)
]

{ #category : #running }
MABooleanVectorTest >> testNewWithAll [
	
	v := MABooleanVector new: 100 withAll: true.
	self assert: v size = 100.
	self assert: (v allSatisfy: #yourself)
]

{ #category : #running }
MABooleanVectorTest >> testNot [
	
	v := MABooleanVector withAll:
			#(false false true true false false true true).
	self assert: v not size = 8.
	self
		assert: v not asArray = #(true true false false true true false false)
]

{ #category : #running }
MABooleanVectorTest >> testOr [
	
	| w vw |
	v := MABooleanVector withAll:
			#(false false true true false false true true).
	w := MABooleanVector withAll:
			#(false true false true true false true false).
	vw := v | w.
	self assert: vw size = 8.
	self assert: vw asArray = #(false true true true true false true true)
]

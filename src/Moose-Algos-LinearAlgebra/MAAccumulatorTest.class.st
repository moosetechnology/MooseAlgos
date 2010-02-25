"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MAAccumulatorTest,
	#superclass : #TestCase,
	#category : #'Moose-Algos-LinearAlgebra'
}

{ #category : #test }
MAAccumulatorTest >> testAverage [
	
	| a |
	a := MAAccumulator sum.
	a accumulate: 10.
	self assert: a average = 10.
	a accumulate: 1.
	self assert: a average = (11 / 2).
	a accumulate: 100.
	self assert: a average = (111 / 3)
]

{ #category : #test }
MAAccumulatorTest >> testCustomBlock [
	
	| a |
	a := MAAccumulator
		value: 0
		using: [:current :new | current max: new size].
	a accumulate: 'ab'.
	self assert: a value = 2.
	a accumulate: 'a'.
	self assert: a value = 2.
	a accumulate: 'abc'.
	self assert: a value = 3
]

{ #category : #test }
MAAccumulatorTest >> testEnumerate [
	
	| a |
	a := MAAccumulator minimum.
	a enumerate: #(10 1 100).
	self assert: a value = 1
]

{ #category : #test }
MAAccumulatorTest >> testEnumerateWithIndex [
	
	| a |
	a := MAAccumulator minimum.
	a enumerateWithIndex: #(10 1 100).
	self assert: a index = 2.
	self assert: a value = 1
]

{ #category : #test }
MAAccumulatorTest >> testIfTruePut [
	
	| a |
	a := MAAccumulator maximum.
	a accumulate: 10 withIndex: 'first'.
	self assert: a index = 'first'.
	self assert: a value = 10.
	a accumulate: 1 withIndex: 'second'.
	self assert: a index = 'first'.
	self assert: a value = 10.
	a accumulate: 100 withIndex: 'third'.
	self assert: a index = 'third'.
	self assert: a value = 100
]

{ #category : #test }
MAAccumulatorTest >> testMaximum [
	
	| a |
	a := MAAccumulator maximum.
	a accumulate: 10.
	self assert: a value = 10.
	a accumulate: 1.
	self assert: a value = 10.
	a accumulate: 100.
	self assert: a value = 100
]

{ #category : #test }
MAAccumulatorTest >> testMinimum [
	
	| a |
	a := MAAccumulator minimum.
	a accumulate: 10.
	self assert: a value = 10.
	a accumulate: 1.
	self assert: a value = 1.
	a accumulate: 100.
	self assert: a value = 1
]

{ #category : #test }
MAAccumulatorTest >> testSquaredSum [
	
	| a |
	a := MAAccumulator squaredSum.
	a enumerate: #(1 2 3 4 5 6 7 8 9 10).
	self assert: a value = 385
]

{ #category : #test }
MAAccumulatorTest >> testSum [
	
	| a |
	a := MAAccumulator sum.
	a enumerate: #(1 2 3 4 5 6 7 8 9 10).
	self assert: a value = 55
]

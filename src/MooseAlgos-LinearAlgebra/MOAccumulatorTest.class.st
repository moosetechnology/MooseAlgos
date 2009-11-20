"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MOAccumulatorTest,
	#superclass : #TestCase,
	#category : #'MooseAlgos-LinearAlgebra'
}

{ #category : #test }
MOAccumulatorTest >> testAverage [
	
	| a |
	a := MOAccumulator sum.
	a accumulate: 10.
	self assert: a average = 10.
	a accumulate: 1.
	self assert: a average = (11 / 2).
	a accumulate: 100.
	self assert: a average = (111 / 3)
]

{ #category : #test }
MOAccumulatorTest >> testCustomBlock [
	
	| a |
	a := MOAccumulator
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
MOAccumulatorTest >> testEnumerate [
	
	| a |
	a := MOAccumulator minimum.
	a enumerate: #(10 1 100).
	self assert: a value = 1
]

{ #category : #test }
MOAccumulatorTest >> testEnumerateWithIndex [
	
	| a |
	a := MOAccumulator minimum.
	a enumerateWithIndex: #(10 1 100).
	self assert: a index = 2.
	self assert: a value = 1
]

{ #category : #test }
MOAccumulatorTest >> testIfTruePut [
	
	| a |
	a := MOAccumulator maximum.
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
MOAccumulatorTest >> testMaximum [
	
	| a |
	a := MOAccumulator maximum.
	a accumulate: 10.
	self assert: a value = 10.
	a accumulate: 1.
	self assert: a value = 10.
	a accumulate: 100.
	self assert: a value = 100
]

{ #category : #test }
MOAccumulatorTest >> testMinimum [
	
	| a |
	a := MOAccumulator minimum.
	a accumulate: 10.
	self assert: a value = 10.
	a accumulate: 1.
	self assert: a value = 1.
	a accumulate: 100.
	self assert: a value = 1
]

{ #category : #test }
MOAccumulatorTest >> testSquaredSum [
	
	| a |
	a := MOAccumulator squaredSum.
	a enumerate: #(1 2 3 4 5 6 7 8 9 10).
	self assert: a value = 385
]

{ #category : #test }
MOAccumulatorTest >> testSum [
	
	| a |
	a := MOAccumulator sum.
	a enumerate: #(1 2 3 4 5 6 7 8 9 10).
	self assert: a value = 55
]

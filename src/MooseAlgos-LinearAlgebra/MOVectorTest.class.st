"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MOVectorTest,
	#superclass : #TestCase,
	#instVars : [
		'v',
		'w'
	],
	#category : #'MooseAlgos-LinearAlgebra'
}

{ #category : #testing }
MOVectorTest class >> isAbstract [
	
	^self name = #VectorTest
]

{ #category : #fixture }
MOVectorTest >> setUp [
	"comment stating purpose of message"
	
	v := self vectorClass withAll: (1 to: 10).
	w := self vectorClass new: 10 withAll: -5
]

{ #category : #test }
MOVectorTest >> testAccessors [
	"comment stating purpose of message"
	
	v := self vectorClass new: 1.
	v at: 1 put: 77.
	self assert: (v at: 1) ~= 0.
	self assert: (v at: 1) ~= nil
]

{ #category : #test }
MOVectorTest >> testAccessors2 [
	"comment stating purpose of message"
	
	v := self vectorClass new: 3.
	v at: 1 put: 77.
	v at: 2 put: 23.
	v at: 3 put: 42.
	self assert: (v at: 1) = 77.
	self assert: (v at: 2) = 23.
	self assert: (v at: 3) = 42
]

{ #category : #test }
MOVectorTest >> testAccessors3 [
	"comment stating purpose of message"
	
	v := self vectorClass withAll: #(4 5 7).
	v at: 1 put: 77.
	v at: 2 put: 23.
	v at: 3 put: 42.
	self assert: (v at: 1) = 77.
	self assert: (v at: 2) = 23.
	self assert: (v at: 3) = 42
]

{ #category : #test }
MOVectorTest >> testAccessors4 [
	"comment stating purpose of message"
	
	v := self vectorClass withAll: #(4 5 7).
	v at: 1 put: 0.
	v at: 2 put: 0.
	v at: 3 put: 0.
	self assert: (v at: 1) = 0.
	self assert: (v at: 2) = 0.
	self assert: (v at: 3) = 0
]

{ #category : #test }
MOVectorTest >> testDifference [
	"comment stating purpose of message"
	
	self assert: v - 2 = (self vectorClass withAll: #(-1 0 1 2 3 4 5 6 7 8)).
	self
		assert:
			2 - v = (self vectorClass withAll: #(1 0 -1 -2 -3 -4 -5 -6 -7 -8)).
	self assert: v - 2 = (2 - v) negated.
	self assert: v - 2 = (v - 2.0d).
	v -= 2.
	self assert: v = (self vectorClass withAll: #(-1 0 1 2 3 4 5 6 7 8))
]

{ #category : #test }
MOVectorTest >> testDotProduct [
	"comment stating purpose of message"
	
	v := self vectorClass withAll: #(1 2 3).
	w := self vectorClass withAll: #(5 -11 7).
	self assert: (v dotProduct: w) = (1 * 5 + (2 * -11) + (3 * 7)).
	self assert: (v dotProduct: v) = (1 * 1 + (2 * 2) + (3 * 3)).
	self assert: (w dotProduct: w) = (5 * 5 + (11 * 11) + (7 * 7))
]

{ #category : #test }
MOVectorTest >> testLength [
	"comment stating purpose of message"
	
	v := self vectorClass withAll: #(1 2 3).
	w := self vectorClass withAll: #(5 -11 7).
	self assert: v length = (1 * 1 + (2 * 2) + (3 * 3)) sqrt.
	self assert: w length = (5 * 5 + (11 * 11) + (7 * 7)) sqrt
]

{ #category : #test }
MOVectorTest >> testNonZeroSize [
	
	v := self vectorClass new: 100 withAll: 0.
	self assert: v sparseSize = 0.
	v at: 23 put: 1.
	self assert: v sparseSize = 1.
	v at: 23 put: 0.
	self assert: v sparseSize = 0.
	v at: 17 put: 1.
	v at: 27 put: 2.
	v at: 77 put: 3.
	self assert: v sparseSize = 3.
	v at: 27 put: 4.
	self assert: v sparseSize = 3.
	v at: 17 put: 0.
	self assert: v sparseSize = 2.
	v at: 43 put: 0.
	self assert: v sparseSize = 2
]

{ #category : #test }
MOVectorTest >> testProduct [
	"comment stating purpose of message"
	
	self
		assert: v * 2 = (self vectorClass withAll: #(2 4 6 8 10 12 14 16 18 20)).
	self assert: v * 2 = (2 * v).
	self assert: v * 2 = (v * 2.0d).
	v *= 2.
	self assert: v = (self vectorClass withAll: #(2 4 6 8 10 12 14 16 18 20))
]

{ #category : #test }
MOVectorTest >> testProductVector [
	"comment stating purpose of message"
	
	self
		assert:
			v * w
				= (self vectorClass withAll: #(-5 -10 -15 -20 -25 -30 -35 -40 -45 -50)).
	self assert: v * w = (w * v)
]

{ #category : #test }
MOVectorTest >> testQuotient [
	"comment stating purpose of message"
	
	self
		assert:
			v / 2 = (self vectorClass withAll: #(0.5 1 1.5 2 2.5 3 3.5 4 4.5 5)).
	self assert: (2 / v) first = 2.
	self assert: v / 2 = (2 / v) reciprocal.
	self assert: v / 2 = (v / 2.0d).
	v /= 2.
	self
		assert: v = (self vectorClass withAll: #(0.5 1 1.5 2 2.5 3 3.5 4 4.5 5))
]

{ #category : #test }
MOVectorTest >> testReadDenseTextFrom [
	
	| vector text stream |
	vector := MOArrayVector withAll: #(2.3 0 4.2 0 1.3 2.2 3.8 0 0.5 0 0 0).
	text := '12\2.3 0 4.2 0 1.3 2.2 3.8 0 0.5 0 0 0\' withCRs.
	stream := ReadStream on: text.
	self assert: vector = (self vectorClass readFromDenseText: stream)
]

{ #category : #test }
MOVectorTest >> testStoreDenseTextOn [
	
	| vector text stream |
	vector := self vectorClass withAll: #(2.3 0 4.2 0 1.3 2.2 3.8 0 0.5 0 0 0).
	text := '12\2.3 0 4.2 0 1.3 2.2 3.8 0 0.5 0 0 0\' withCRs.
	stream := WriteStream on: String new.
	vector storeDenseTextOn: stream.
	self assert: stream contents = text
]

{ #category : #test }
MOVectorTest >> testSum [
	"comment stating purpose of message"
	
	self assert: v + 2 = (self vectorClass withAll: #(3 4 5 6 7 8 9 10 11 12)).
	self assert: v + 2 = (2 + v).
	self assert: v + 2 = (v + 2.0d).
	v += 2.
	self assert: v = (self vectorClass withAll: #(3 4 5 6 7 8 9 10 11 12))
]

{ #category : #test }
MOVectorTest >> testSumVector [
	"comment stating purpose of message"
	
	self
		assert: v + w = (self vectorClass withAll: #(-4 -3 -2 -1 0 1 2 3 4 5)).
	self assert: v + w = (w + v)
]

{ #category : #test }
MOVectorTest >> testUnitVector [
	"comment stating purpose of message"
	
	self assert: v unitVector length asFloat = 1.0d asFloat.
	self assert: w unitVector length asFloat = 1.0d asFloat
]

{ #category : #fixture }
MOVectorTest >> vectorClass [
	
	self subclassResponsibility
]

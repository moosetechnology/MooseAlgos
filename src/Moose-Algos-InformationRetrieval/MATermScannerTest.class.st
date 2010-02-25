"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MATermScannerTest,
	#superclass : #TestCase,
	#category : #'Moose-Algos-InformationRetrieval'
}

{ #category : #running }
MATermScannerTest >> testDanglingLetter [
	
	self assert: (MATermScanner scan: '   a') asArray = #('a')
]

{ #category : #running }
MATermScannerTest >> testEmptyString [
	
	self assert: (MATermScanner scan: '') isEmpty
]

{ #category : #running }
MATermScannerTest >> testNonLetter [
	
	self assert: (MATermScanner scan: '123456') isEmpty.
	self assert: (MATermScanner scan: 'abc123abc') asArray = #('abc' 'abc')
]

{ #category : #running }
MATermScannerTest >> testScanWords [
	
	self
		assert: (MATermScanner scan: 'foo')
		equals: #('foo').
	self
		assert: (MATermScanner scan: 'foo bar')
		equals: #('foo' 'bar')
]

{ #category : #running }
MATermScannerTest >> testTrailingWhitespace [
	
	self assert: (MATermScanner scan: 'foo') asArray = #('foo').
	self assert: (MATermScanner scan: '  foo  ') asArray = #('foo')
]

{ #category : #running }
MATermScannerTest >> testWhitespaceString [
	
	self assert: (MATermScanner scan: '               ') isEmpty.
	self assert: (MATermScanner scan: 'foo') asArray = #('foo').
	self assert: (MATermScanner scan: '  foo  ') asArray = #('foo')
]

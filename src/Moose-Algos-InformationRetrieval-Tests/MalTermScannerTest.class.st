"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MalTermScannerTest,
	#superclass : #TestCase,
	#category : #'Moose-Algos-InformationRetrieval-Tests'
}

{ #category : #tests }
MalTermScannerTest >> testDanglingLetter [
	self assert: (MalTermScanner scan: '   a') asArray equals: #('a')
]

{ #category : #tests }
MalTermScannerTest >> testEmptyString [
	
	self assert: (MalTermScanner scan: '') isEmpty
]

{ #category : #tests }
MalTermScannerTest >> testNonLetter [
	self assert: (MalTermScanner scan: '123456') isEmpty.
	self assert: (MalTermScanner scan: 'abc123abc') asArray equals: #('abc' 'abc')
]

{ #category : #tests }
MalTermScannerTest >> testScanWords [
	
	
		
		self
assert: (MalTermScanner scan: 'foo') asArray 
equals: #('foo').
	
		self
assert: (MalTermScanner scan: 'foo bar') asArray 
equals: #( 'bar' 'foo')
		"self
assert: (MATermScanner scan: 'foo')  
equals: #('foo').
	
		self
assert: (MATermScanner scan: 'foo bar') 
equals: #('foo' 'bar')"
]

{ #category : #tests }
MalTermScannerTest >> testTrailingWhitespace [
	self assert: (MalTermScanner scan: 'foo') asArray equals: #('foo').
	self assert: (MalTermScanner scan: '  foo  ') asArray equals: #('foo')
]

{ #category : #tests }
MalTermScannerTest >> testWhitespaceString [
	self assert: (MalTermScanner scan: '               ') isEmpty.
	self assert: (MalTermScanner scan: 'foo') asArray equals: #('foo').
	self assert: (MalTermScanner scan: '  foo  ') asArray equals: #('foo')
]

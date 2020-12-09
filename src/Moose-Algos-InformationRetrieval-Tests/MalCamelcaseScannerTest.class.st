"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MalCamelcaseScannerTest,
	#superclass : #TestCase,
	#category : #'Moose-Algos-InformationRetrieval-Tests'
}

{ #category : #tests }
MalCamelcaseScannerTest >> testCompleteSentence [
	
	self
		assert:
			(MalCamelcaseScanner scan: 'TheNextBIGThing isKindOf: Hype, VeryBIG BIG')
		equals:
			#('the' 'next' 'BIG' 'thing' 'is' 'kind' 'of' 'hype' 'very' 'BIG' 'BIG') asBag.
]

{ #category : #tests }
MalCamelcaseScannerTest >> testDanglingLetter [
	
	
		self
	assert: (MalCamelcaseScanner scan: 'a')
	equals: #('a') asBag.
	
		self
	assert: (MalCamelcaseScanner scan: 'A')
	equals: #('A') asBag.
	
		self
	assert: (MalCamelcaseScanner scan: 'fooA')
	equals: #('foo' 'A') asBag
]

{ #category : #tests }
MalCamelcaseScannerTest >> testEmptyString [
	
	
		self assert: (MalCamelcaseScanner scan: '') isEmpty.
	
		self assert: (MalCamelcaseScanner scan: '     ') isEmpty
]

{ #category : #tests }
MalCamelcaseScannerTest >> testNonLetter [
	
	
		self assert: (MalCamelcaseScanner scan: '123456') isEmpty.
	
		self
assert: (MalCamelcaseScanner scan: 'abc123abc')
	equals: #('abc' 'abc') asBag
]

{ #category : #tests }
MalCamelcaseScannerTest >> testScanAcronymWords [
	
	
		self
assert: (MalCamelcaseScanner scan: 'TheNextBIGThing')
equals: #('the' 'next' 'BIG' 'thing') asBag.
	
		self
assert: (MalCamelcaseScanner scan: 'TheNextBIG')
equals: #('the' 'next' 'BIG') asBag.
	
		self
assert: (MalCamelcaseScanner scan: 'BIGThing')
	equals: #('BIG' 'thing') asBag.
	
		self
assert: (MalCamelcaseScanner scan: 'BIG')
		equals: #('BIG') asBag.
	
		self
assert: (MalCamelcaseScanner scan: 'TheNextBIG Thing')
equals: #('the' 'next' 'BIG' 'thing') asBag.
]

{ #category : #tests }
MalCamelcaseScannerTest >> testScanWords [
	
	
		
		self
assert: (MalCamelcaseScanner scan: 'foo')
	equals: #('foo') asBag.
	
		self
assert: (MalCamelcaseScanner scan: 'fooBar')
	equals: #('foo' 'bar')asBag.
	
		self
assert: (MalCamelcaseScanner scan: 'FooBar')
	equals: #('foo' 'bar') asBag.
	
		self
assert: (MalCamelcaseScanner scan: 'FooBar ')
equals: #('foo' 'bar') asBag
]

{ #category : #tests }
MalCamelcaseScannerTest >> testWhiteSpaces [
	
	
		self
assert: (MalCamelcaseScanner scan: 'foo')
	equals: #('foo') asBag.
	
		self
assert: (MalCamelcaseScanner scan: 'fooBar')
equals: #('foo' 'bar') asBag.
	
		self
assert: (MalCamelcaseScanner scan: 'FooBar')
	equals: #('foo' 'bar') asBag
]

{ #category : #tests }
MalCamelcaseScannerTest >> testZeroWordAreWhitespace [
	
	
		self
assert: (MalCamelcaseScanner scan: 'foo100Bar')
equals: #('foo' 'bar') asBag.
	
		self
assert: (MalCamelcaseScanner scan: 'foo10 0Bar')
	equals: #('foo') asBag.
	
		self
assert: (MalCamelcaseScanner scan: '0xFFFF foo')
	equals: #('foo') asBag.
	
		self
assert: (MalCamelcaseScanner scan: ' 0xFFFF foo')
equals: #('foo') asBag
]

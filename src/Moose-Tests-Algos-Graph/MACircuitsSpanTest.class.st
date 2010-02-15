Class {
	#name : #MACircuitsSpanTest,
	#superclass : #TestCase,
	#instVars : [
		'cspan'
	],
	#category : #'Moose-Tests-Algos-Graph'
}

{ #category : #running }
MACircuitsSpanTest >> circuit: circuit1 equals: circuit2 [

	| perm |
	^ (circuit1 hasEqualElements: circuit2)
		ifTrue: [ true ]
		ifFalse: [ "find the right permutation starting with the same node then compare both sequences"
			perm := circuit2 copy.
			[ circuit1 first = perm first ] whileFalse: [
								perm addLast: perm removeFirst.
								perm first = circuit2 first
									ifTrue: [ ^ false "we made a full permutation cycle without finding the start, so it's false" ] ].
			circuit1 hasEqualElements: perm
		]
	
]

{ #category : #running }
MACircuitsSpanTest >> setUp [ 

	cspan := MACircuitsSpan new.
]

{ #category : #tests }
MACircuitsSpanTest >> testBasicCircuit [
	"
	self debug: #testBasicCircuit 
	"

	MOGraphFixture aseCircuitGraph: cspan.
	cspan run.
	self assert: 5
			equals: cspan circuits size.
	self assert: (self circuit: #($g $h) equals: cspan circuits first).
	self assert: (self circuit: #($b $d) equals: cspan circuits second).
	self assert: (self circuit: #($a $b) equals: cspan circuits third).
	self assert: (self circuit: #($c $d $b) equals: cspan circuits fourth).
	self assert: (self circuit: #($e $a $b $d) equals: cspan circuits fifth).
]

{ #category : #tests }
MACircuitsSpanTest >> testCseSingleCircuit [
	"
	self debug: #testCseSingleCircuit 
	"

	| cse |
	cse := MACircuitSpanningEdges new.
	MOGraphFixture aseSingleCircuitGraph: cse.
	cse run.
	self assert: 4
			equals: cse circuits size.
	self assert: (#($a $b) hasEqualElements: cse circuits first).
	self assert: (#($b $d) hasEqualElements: cse circuits second).
	self assert: (#($c $d $b) hasEqualElements: cse circuits third).
	self assert: (#($e $a $b $d) hasEqualElements: cse circuits fourth).
]

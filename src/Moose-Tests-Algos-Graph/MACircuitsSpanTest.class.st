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
MACircuitsSpanTest >> testAseCircuit [
	"
	self debug: #testAseCircuit 
	"

	MOGraphFixture aseCircuitGraph: cspan.
	cspan run.
	self assert: 5
			equals: cspan circuits size.
	#(($g $h) ($b $d) ($a $b) ($c $d $b) ($e $a $b $d)) do: [:c|
			self assert: (cspan circuits anySatisfy: [:ci|
				self circuit: c equals: ci]) ].

]

{ #category : #tests }
MACircuitsSpanTest >> testAseScc [
	"
	self debug: #testAseScc 
	"

	| cse |
	cse := MACircuitSpanningEdges new.
	MOGraphFixture aseSccGraph: cse.
	cse run.
	self assert: 4
			equals: cse circuits size.
	self assert: (#($a $b) hasEqualElements: cse circuits first).
	self assert: (#($b $d) hasEqualElements: cse circuits second).
	self assert: (#($c $d $b) hasEqualElements: cse circuits third).
	self assert: (#($e $a $b $d) hasEqualElements: cse circuits fourth).
]

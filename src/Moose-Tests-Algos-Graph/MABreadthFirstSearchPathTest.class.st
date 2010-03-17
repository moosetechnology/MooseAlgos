Class {
	#name : #MABreadthFirstSearchPathTest,
	#superclass : #TestCase,
	#instVars : [
		'bfsp'
	],
	#category : #'Moose-Tests-Algos-Graph'
}

{ #category : #'as yet unclassified' }
MABreadthFirstSearchPathTest >> setUp [ 

	bfsp := MABreadthFirstSearchPath new.
]

{ #category : #'as yet unclassified' }
MABreadthFirstSearchPathTest >> testAseGraph [
	"
	self debug: #testAseGraph
	"

	MOGraphFixture aseCircuitGraph: bfsp.
	self assert: (#($a $b $c) hasEqualElements: (bfsp runFrom: $a to: $c)).
	self assert: (#($d $b $c) hasEqualElements: (bfsp runFrom: $d to: $c)).
	self assert: (#($e $a) hasEqualElements: (bfsp runFrom: $e to: $a)).
	self assert: (#($a $b $d $e) hasEqualElements: (bfsp runFrom: $a to: $e)).
	self assert: (#($d $b $c $f) hasEqualElements: (bfsp runFrom: $d to: $f)).
	self should: [bfsp runFrom: $f to: $a] raise: Error.

]

{ #category : #'as yet unclassified' }
MABreadthFirstSearchPathTest >> testSimpleGraph [
	"
	self debug: #testSimpleGraph
	"

	MOGraphFixture simpleGraph: bfsp.
	self assert: (#($a $b $c) hasEqualElements: (bfsp runFrom: $a to: $c)).
	self assert: (#($d $c) hasEqualElements: (bfsp runFrom: $d to: $c)).
]

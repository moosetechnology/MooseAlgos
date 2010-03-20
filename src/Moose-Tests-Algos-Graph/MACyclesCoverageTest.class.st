Class {
	#name : #MACyclesCoverageTest,
	#superclass : #TestCase,
	#instVars : [
		'cc'
	],
	#category : #'Moose-Tests-Algos-Graph'
}

{ #category : #running }
MACyclesCoverageTest >> setUp [ 

	cc := MACyclesCoverage new.
]

{ #category : #'tests-sed' }
MACyclesCoverageTest >> testAseCircuit [
	"
	self debug: #testAseCircuit 
	"

	MOGraphFixture aseCircuitGraph: cc.
	cc run.
	self assert: 5
			equals: cc circuits size.
	#(($g $h) ($b $d) ($a $b) ($b $c $d) ($a $b $d $e)) do: [:c|
			self assert: (cc circuits anySatisfy: [:ci| c hasEqualElements: ci ])].

]

{ #category : #'tests-cse' }
MACyclesCoverageTest >> testAseCircuit2 [
	"
	self debug: #testAseCircuit 
	"

	cc useCircuitSpan.
	MOGraphFixture aseCircuitGraph: cc.
	cc run.
	self assert: 5
			equals: cc circuits size.
	#(($g $h) ($b $d) ($a $b) ($b $c $d) ($a $b $d $e)) do: [:c|
			self assert: (cc circuits anySatisfy: [:ci| c hasEqualElements: (cc normalize: ci) ])].

]

{ #category : #'tests-sed' }
MACyclesCoverageTest >> testAseScc [
	"
	self debug: #testAseScc 
	"

	| sed circuits |
	sed := MASccEdgeDecomposition new.
	MOGraphFixture aseSccGraph: sed.
	sed run.
	self assert: 4
			equals: sed circuits size.
	circuits := sed circuits asOrderedCollection.
	#(($b $d) ($a $b) ($b $c $d) ($a $b $d $e)) do: [:c|
			self assert: (circuits anySatisfy: [:ci| c hasEqualElements: ci ])].

]

{ #category : #'tests-cse' }
MACyclesCoverageTest >> testAseScc2 [
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

{ #category : #'tests-sed' }
MACyclesCoverageTest >> testNormalize [
	"
	self debug: #testNormalize
	"
	
	self assert: (#($a $b) hasEqualElements: (cc normalize: #($a $b) asOrderedCollection)).
	self assert: (#($a $b) hasEqualElements: (cc normalize: #($b $a) asOrderedCollection)).
	self assert: (#($b $c $d) hasEqualElements: (cc normalize: #($c $d $b) asOrderedCollection)).	
	self assert: (#($a $e $b $f $d) hasEqualElements: (cc normalize: #($e $b $f $d $a) asOrderedCollection)).	

]

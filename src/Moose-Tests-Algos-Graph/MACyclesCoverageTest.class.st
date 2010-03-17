Class {
	#name : #MACyclesCoverageTest,
	#superclass : #TestCase,
	#instVars : [
		'sed',
		'cc'
	],
	#category : #'Moose-Tests-Algos-Graph'
}

{ #category : #running }
MACyclesCoverageTest >> setUp [ 

	cc := MACyclesCoverage new.
	sed := MASccEdgeDecomposition new.
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

{ #category : #'tests-sed' }
MACyclesCoverageTest >> testAseScc [
	"
	self debug: #testAseScc 
	"

	| circuits |
	MOGraphFixture aseSccGraph: sed.
	sed run.
	self assert: 4
			equals: sed circuits size.
	circuits := sed circuits asOrderedCollection.
	#(($b $d) ($a $b) ($b $c $d) ($a $b $d $e)) do: [:c|
			self assert: (circuits anySatisfy: [:ci| c hasEqualElements: ci ])].

]

{ #category : #'tests-sed' }
MACyclesCoverageTest >> testNormalize [
	"
	self debug: #testNormalize
	"
	
	self assert: (#($a $b) hasEqualElements: (sed normalize: #($a $b) asOrderedCollection)).
	self assert: (#($a $b) hasEqualElements: (sed normalize: #($b $a) asOrderedCollection)).
	self assert: (#($b $c $d) hasEqualElements: (sed normalize: #($c $d $b) asOrderedCollection)).	
	self assert: (#($a $e $b $f $d) hasEqualElements: (sed normalize: #($e $b $f $d $a) asOrderedCollection)).	

]

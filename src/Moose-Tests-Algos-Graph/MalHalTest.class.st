Class {
	#name : #MalHalTest,
	#superclass : #TestCase,
	#instVars : [
		'hal'
	],
	#category : #'Moose-Tests-Algos-Graph'
}

{ #category : #tests }
MalHalTest >> setUp [

	hal := MalHal new.

]

{ #category : #tests }
MalHalTest >> testComplexCycle [

	(MalGraphFixture complexCycleGraph: hal) run.

	self assert: (hal findNode: $a) hNumber = 0.
	self assert: (hal findNode: $b) hNumber = 3.
	self assert: (hal findNode: $c) hNumber = 2.
	self assert: (hal findNode: $d) hNumber = 2.
	self assert: (hal findNode: $e) hNumber = 4.
	self assert: (hal findNode: $f) hNumber = 2.
	self assert: (hal findNode: $g) hNumber = 1.
	self assert: (hal findNode: $h) hNumber = 1.

	hal showLevels 
]

{ #category : #tests }
MalHalTest >> testCycle [

	(MalGraphFixture cycleGraph: hal) run.

	self assert: (hal findNode: $a) hNumber = 1.
	self assert: (hal findNode: $b) hNumber = 1.
	self assert: (hal findNode: $c) hNumber = 1.
	self assert: (hal findNode: $d) hNumber = 0.

	hal showLevels 
]

{ #category : #tests }
MalHalTest >> testModuleGraph [

	(MalGraphFixture moduleGraph: hal) run.

	self assert: (hal findNode: 'v1') hNumber = 0.
	self assert: (hal findNode: 'v2') hNumber = 1.
	self assert: (hal findNode: 'v3') hNumber = 1.
	self assert: (hal findNode: 'v4') hNumber = 1.
	self assert: (hal findNode: 'v5') hNumber = 2.
	self assert: (hal findNode: 'v6') hNumber = 3.
	self assert: (hal findNode: 'v7') hNumber = 3.
	self assert: (hal findNode: 'v8') hNumber = 4.
	self assert: (hal findNode: 'v9') hNumber = 5.
	self assert: (hal findNode: 'v10') hNumber = 6.
	self assert: (hal findNode: 'v11') hNumber = 6.

	hal showLevels 
]

{ #category : #tests }
MalHalTest >> testModuleGraph2 [

	(MalGraphFixture moduleGraph2: hal) run.

	self assert: (hal findNode: $u) hNumber = 0.
	self assert: (hal findNode: $w) hNumber = 1.
	self assert: (hal findNode: $a) hNumber = 2.
	self assert: (hal findNode: $c) hNumber = 2.
	self assert: (hal findNode: $v) hNumber = 3.
	self assert: (hal findNode: $d) hNumber = 4.
	self assert: (hal findNode: $z) hNumber = 5.
	self assert: (hal findNode: $b) hNumber = 6.

	hal showLevels 
]

{ #category : #tests }
MalHalTest >> testNestedCycle [

	(MalGraphFixture nestedCycleGraph: hal) run.
	
	self assert: (hal findNode: $a) hNumber = 0.
	self assert: (hal findNode: $b) hNumber = 0.
	self assert: (hal findNode: $c) hNumber = 0.
	self assert: (hal findNode: $d) hNumber = 0.
	self assert: (hal findNode: $e) hNumber = 0.
	self assert: (hal findNode: $f) hNumber = 1.
	self assert: (hal findNode: $g) hNumber = 1.
	self assert: (hal findNode: $h) hNumber = 1.
	self assert: (hal findNode: $i) hNumber = 1.
	
	hal showLevels 
]

{ #category : #tests }
MalHalTest >> testSimpleGraph [

	(MalGraphFixture simpleGraph: hal) run.
	
	self assert: (hal findNode: $a) hNumber = 0.
	self assert: (hal findNode: $d) hNumber = 0.
	self assert: (hal findNode: $b) hNumber = 1.
	self assert: (hal findNode: $c) hNumber = 2.

	hal showLevels 
]

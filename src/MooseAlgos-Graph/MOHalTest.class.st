Class {
	#name : #MOHalTest,
	#superclass : #TestCase,
	#instVars : [
		'hal'
	],
	#category : #'MooseAlgos-Graph-Tests'
}

{ #category : #history }
MOHalTest class >> lastStoredRun [
	^ ((Dictionary new) add: (#passed->((Set new) add: #testComplexCycle; add: #testCycle; add: #testNestedCycle; add: #testSimpleGraph; yourself)); add: (#timeStamp->'4 September 2009 11:02:20 pm' asTimeStamp); add: (#failures->((Set new) add: #testModuleGraph; add: #testModuleGraph2; yourself)); add: (#errors->((Set new))); yourself)
]

{ #category : #tests }
MOHalTest >> setUp [

	hal := MOHal new.

]

{ #category : #tests }
MOHalTest >> testComplexCycle [

	(MOGraphFixture complexCycleGraph: hal) run.

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
MOHalTest >> testCycle [

	(MOGraphFixture cycleGraph: hal) run.

	self assert: (hal findNode: $a) hNumber = 1.
	self assert: (hal findNode: $b) hNumber = 1.
	self assert: (hal findNode: $c) hNumber = 1.
	self assert: (hal findNode: $d) hNumber = 0.

	hal showLevels 
]

{ #category : #tests }
MOHalTest >> testModuleGraph [

	self flag: #copyFixture.
	self fail.
	hal nodes: GraphFixture moduleGraph.
	hal computeHierarchyNumbers.

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
MOHalTest >> testModuleGraph2 [

	self flag: #copyFixture.
	self fail.
	hal nodes: GraphFixture moduleGraph2.
	hal computeHierarchyNumbers.

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
MOHalTest >> testNestedCycle [

	(MOGraphFixture nestedCycleGraph: hal) run.
	
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
MOHalTest >> testSimpleGraph [

	(MOGraphFixture simpleGraph: hal) run.
	
	self assert: (hal findNode: $a) hNumber = 0.
	self assert: (hal findNode: $d) hNumber = 0.
	self assert: (hal findNode: $b) hNumber = 1.
	self assert: (hal findNode: $c) hNumber = 2.

	hal showLevels 
]

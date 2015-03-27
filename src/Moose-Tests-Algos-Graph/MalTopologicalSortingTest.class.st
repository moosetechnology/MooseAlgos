"
A MalTopologicalSortingTest is a test class for testing the behavior of MalTopologicalSorting
"
Class {
	#name : #MalTopologicalSortingTest,
	#superclass : #TestCase,
	#instVars : [
		'sorter'
	],
	#category : #'Moose-Tests-Algos-Graph'
}

{ #category : #running }
MalTopologicalSortingTest >> setUp [
	super setUp.
	sorter := MalTopologicalSorting new
]

{ #category : #tests }
MalTopologicalSortingTest >> testSortStringHierarchy [
	sorter
		addNodesFrom: String
		childrenBlock: [ :class | class subclasses ].

	self
		assertCollection: (sorter run collect: [ :item | item model ] as: Array)
		equals: { WideSymbol . ByteSymbol . Symbol . WideString . ByteString . String }
]

{ #category : #tests }
MalTopologicalSortingTest >> testSortWithCycle [
	MalGraphFixture cycleGraph: sorter.
	self
		should: [ sorter run ]
		raise: Error
]

{ #category : #tests }
MalTopologicalSortingTest >> testSortWithoutCyclesComplexGraph [
	MalGraphFixture withoutCyclesComplexGraph: sorter.
	self
		assertCollection: (sorter run collect: [ :item | item model ] as: Array)
		equals: #($s $r $i $f $p $n $m $d $q $o $l $k $h $c $g $e $j $b $a)
]

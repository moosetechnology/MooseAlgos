Class {
	#name : #MOKruskalTest,
	#superclass : #TestCase,
	#instVars : [
		'nodes',
		'kruskal'
	],
	#category : #'MooseAlgos-Graph-Tests'
}

{ #category : #history }
MOKruskalTest class >> lastStoredRun [
	^ ((Dictionary new) add: (#passed->((Set new) add: #testMaxSpanningTree2; add: #testMinSpanningTree; add: #testMaxSpanningTree; add: #testMinSpanningTree1; add: #testUnionFind; yourself)); add: (#timeStamp->'6 July 2009 5:40:15 pm' asTimeStamp); add: (#failures->((Set new))); add: (#errors->((Set new))); yourself)
]

{ #category : #running }
MOKruskalTest >> setUp [

	kruskal := MOKruskal new.
	nodes := OrderedCollection new.
	nodes add: MODisjointSetNode new.
	nodes add: MODisjointSetNode new.
	nodes add: MODisjointSetNode new.
	nodes add: MODisjointSetNode new
]

{ #category : #tests }
MOKruskalTest >> testMaxSpanningTree [


	| tree expectedEdges |
	MOGraphFixture simpleWeightedGraph: kruskal.
	kruskal maxSpanningTree.
	tree := kruskal run collect: [:e| e asTuple].

	expectedEdges := #((1 2 5) (3 4 5) (1 3 4) (1 5 3)).
	expectedEdges do: [:e|
		self assert: (tree includes: e)
	].
	tree do: [:e|
		self assert: (expectedEdges includes: e)	
	]
]

{ #category : #tests }
MOKruskalTest >> testMaxSpanningTree2 [


	| tree expectedEdges |
	MOGraphFixture complexWeightedGraph: kruskal.
	kruskal maxSpanningTree.
	tree := kruskal run collect: [:e| e asTuple].

	expectedEdges := #(($a $b 30) ($b $s 1) ($b $c 30) ($d $e 30) ($d $f 20) ($d $j 10) ($e $a 15) ($f $m 8) ($g $h 20) ($g $r 3) ($i $a 14) ($i $k 4) ($j $q 5) ($k $l 10) ($k $g 5) ($m $n 7) ($m $o 6) ($p $b 5)).
	expectedEdges do: [:e|
		self assert: (tree includes: e)
	].
	tree do: [:e|
		self assert: (expectedEdges includes: e)	
	]
]

{ #category : #tests }
MOKruskalTest >> testMinSpanningTree [

	| tree expectedEdges |
	MOGraphFixture simpleWeightedGraph: kruskal.
	tree := kruskal run collect: [:e| e asTuple].

	expectedEdges := #((4 5 1) (5 1 2) (2 3 2) (2 4 3)).
	"self assert: tree asArray = expectedEdges."
	expectedEdges do: [:e|
		self assert: (tree includes: e)
	].
	tree do: [:e|
		self assert: (expectedEdges includes: e)	
	]
]

{ #category : #tests }
MOKruskalTest >> testMinSpanningTree1 [

	| tree expectedEdges |
	MOGraphFixture complexWeightedGraph: kruskal.
	tree := kruskal run collect: [:e| e asTuple].

	expectedEdges := #(($a $b 30) ($b $s 1) ($b $p 4) ($d $f 20) ($e $a 15) ($f $m 8) ($g $h 20) ($g $r 3) ($i $a 14) ($i $k 4) ($i $d 3) ($j $q 5) ($k $l 10) ($k $g 5) ($m $n 7) ($m $o 6) ($n $c 5) ($q $i 4)).
	"self assert: tree asArray = expectedEdges."
	expectedEdges do: [:e|
		self assert: (tree includes: e)
	].
	tree do: [:e|
		self assert: (expectedEdges includes: e)	
	]
]

{ #category : #tests }
MOKruskalTest >> testUnionFind [

	| node1 node2 node3 node4 |
	nodes do: [:node |
		self assert: (node parent = nil).
		node makeSet.
		self assert: (node parent = node).
		self assert: (node find = node)
	].
	node1 := nodes at: 1.
	node2 := nodes at: 2.
	node3 := nodes at: 3.
	node4 := nodes at: 4.
	
	node1 union: node2.
	self assert: (node1 find = node1).
	self assert: (node2 find = node1).
	
	node2 union: node3.
	self assert: (node2 find = node1).
	self assert: (node3 find = node1).
	self assert: (node3 parent = node1).
	
	node4 union: node1.
	nodes do: [ :node |
		self assert: (node find = node4)
	].
	self assert: node1 parent = node4.
	self assert: node2 parent = node1.
	self assert: node3 parent = node1.
	self assert: node4 parent = node4.
]

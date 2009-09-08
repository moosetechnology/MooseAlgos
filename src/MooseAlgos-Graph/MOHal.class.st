Class {
	#name : #MOHal,
	#superclass : #MOTarjan,
	#instVars : [
		'nodesToVisit'
	],
	#category : #'MooseAlgos-Graph'
}

{ #category : #'as yet unclassified' }
MOHal >> hierarchyLevels [

	| map level |
	map := Dictionary new.
	self nodes do: [ :node | 
		level := map at: node hNumber ifAbsentPut: [OrderedCollection new].
		level add: node
	].
	^ map
]

{ #category : #'as yet unclassified' }
MOHal >> nodeClass [

	^ MOHalNode
]

{ #category : #'as yet unclassified' }
MOHal >> run [

	| entryNodes cnode touchedCycle |
	
	"Run Tarjan"
	super run.
	
	"initialization Hal"
	nodesToVisit := OrderedCollection new.
	self nodes do: [ :node | node removeCycleFromEdges ].
	entryNodes := self nodes select: [ :node | node isSource ].
	entryNodes do: [ :n | n hNumber: 0 ].
	nodesToVisit addAll: entryNodes.
	
	"main loop"
	[ nodesToVisit isEmpty ] whileFalse: 
		[ cnode := nodesToVisit removeFirst.
		cnode nextNodes do: 
			[ :next | 
			touchedCycle := next markHNumber: cnode hNumber + 1.
			nodesToVisit addAll: touchedCycle ]. 
		nodesToVisit addAll: cnode nextNodes
	]
]

{ #category : #'as yet unclassified' }
MOHal >> showLevels [

	self hierarchyLevels keysAndValuesDo: [ :k :v |
			Transcript show: k.
			v do: [ :n | Transcript show: ' ' ; show: n ].
			Transcript cr
		]
]

Class {
	#name : #MOTarjan,
	#superclass : #MOGraphAlgorithm,
	#instVars : [
		'visitList',
		'stack',
		'runningIndex'
	],
	#category : #'MooseAlgos-Graph'
}

{ #category : #sample }
MOTarjan class >> mondrianSample [
	"
	MOTarjan mondrianSample
	"

	| nodes edges g tarjan colorDic i color view b |
	b := MOGraphStructure new nodeClass: MOGraphNode; edgeClass: MOGraphEdge.
	MOGraphFixture complexCycleGraph: b.
	nodes := b nodes.
	edges := b edges.

	view := MOViewRenderer new.
	view interaction item: 'show me the cycle' action: [:modelNode|
		g := (view nodeForDomainValue: modelNode).
		tarjan := MOTarjan new.
 		tarjan nodes: g children.
		tarjan edges: g edges from: #source to: #target.
		tarjan run.
		colorDic := IdentityDictionary new.
		i := 1.
		tarjan nodes do: [ :n | 
			color := Color strongColors at: i.
			i := i + 1.
			colorDic at: n model ifAbsentPut: color.
			n cycleNodes do: [:cn| colorDic at: cn model ifAbsentPut: color ] ].
		g children do: [:e | e copyShapeAndDo: [:p | p fillColor: (colorDic at: e)]].
		view updateWindow.
		].

	view nodes: (1 to: 5) forEach: [:each |
		view shape rectangle square: 20.
		view nodes: nodes.
		view shape: (MOArrowedLineShape new).
		view edges: edges from: #from to: #to fromGlobal: false toGlobal: false.
		view circleLayout.
	].
	view open.

]

{ #category : #configuration }
MOTarjan >> nodeClass [

	^ MOTarjanNode 
]

{ #category : #running }
MOTarjan >> putOnStack: aTarjanNode [

	stack push: aTarjanNode.
	aTarjanNode inStack: true. "I use a flag to avoid stack access"
]

{ #category : #running }
MOTarjan >> run [
	"Tarjan's' algorithm to detect strongly connected components (aka cycles) in O(m+n)"
	stack := Stack new.
	runningIndex := 0.
	self nodes do: [ :n | n isTarjanUndefined ifTrue: [ self traverse: n ] ]
]

{ #category : #running }
MOTarjan >> traverse: aTarjanNode [ 
	| pNode component |
	aTarjanNode tarjanIndex: runningIndex.
	aTarjanNode tarjanLowlink: runningIndex.
	runningIndex := runningIndex + 1.
	self putOnStack: aTarjanNode.
	aTarjanNode nextNodes do: 
		[ :next | 
		next isTarjanUndefined 
			ifTrue: 
				[ self traverse: next.
				aTarjanNode tarjanLowlink: (aTarjanNode tarjanLowlink min: next tarjanLowlink) ]
			ifFalse: 
				[ next inStack ifTrue: 
					[ aTarjanNode tarjanLowlink: (aTarjanNode tarjanLowlink min: next tarjanIndex) ] ] ].
	aTarjanNode tarjanIndex = aTarjanNode tarjanLowlink ifTrue: 
		[ component := OrderedCollection new.
		
		[ pNode := stack pop.
		pNode popped.
		component add: pNode
		"Transcript show: pNode; show: ' '." ] doWhileFalse: [ pNode = aTarjanNode ].
		component do: 
			[ :each | 
			each cycleNodes: component
			"Transcript cr" ] ]
]

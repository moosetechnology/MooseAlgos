Extension { #name : #MATarjan }

{ #category : #'*Moose-Tests-Algos-Graph' }
MATarjan classSide >> mondrianSample [
	"
	MOTarjan mondrianSample
	"

	| nodes edges g tarjan colorDic i color view b |
	b := MAGraphStructure new nodeClass: MAGraphNode; edgeClass: MAGraphEdge.
	MAGraphFixture complexCycleGraph: b.
	nodes := b nodes.
	edges := b edges.

	view := MOViewRenderer new.
	view interaction item: 'show me the cycle' action: [:modelNode|
		g := (view nodeForDomainValue: modelNode).
		tarjan := MATarjan new.
 		tarjan nodes: g nodes.
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

Extension { #name : #MalKruskal }

{ #category : #'*Moose-Tests-Algos-Graph' }
MalKruskal class >> mondrianSample [
	"
	MalKruskal mondrianSample
	"
 
	| kruskal tree otherEdges edges view |
	kruskal := MalKruskal new.
	MalGraphFixture complexWeightedGraph: kruskal.
	tree := kruskal run.
	
	view := (Smalltalk at: #ROMondrianViewBuilder) new.
	view nodes: kruskal nodes.
	view shape: ((Smalltalk at: #ROLine) new width: 3).
	edges := view edges: tree from: #from to: #to.

	view shape: ((Smalltalk at: #ROLine) new color: Color red; width: 2).
	otherEdges := kruskal edges copyWithoutAll: tree.
	otherEdges := view edges: otherEdges from: #from to: #to.

	view treeLayout userDefinedEdges: edges.
	view open.
]

Class {
	#name : #MalHgRepositoryTests,
	#superclass : #TestCase,
	#category : #'Moose-Tests-Algos-HierarchicalGraph'
}

{ #category : #tests }
MalHgRepositoryTests >> testHiGraphRepositoryCache [
	| aModel hg |
	
	MalHgRepository flush.
	
	aModel := MalHgTestResources get: 'simpleSample'.
	MalHierarchicalGraph with: aModel name: nil.
	self assert: (MalHgRepository repository isEmpty).
	
	aModel := MalHgTestResources get: 'famix'.
	
	hg := MalHierarchicalGraph with: aModel name: 'famixHiGraph'.
	MalHgRepository repo at: 'famixHiGraph' put: hg.
	self assert: MalHgRepository repository notEmpty.
	self assert: MalHgRepository repository anyOne class = MalHierarchicalGraph.
	self assert: MalHgRepository repository anyOne class = MalHierarchicalGraph.
	self assert: MalHgRepository repository anyOne == hg.
	
	MalHgRepository flush.
	
]

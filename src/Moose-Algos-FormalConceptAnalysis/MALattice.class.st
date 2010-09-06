Class {
	#name : #MALattice,
	#superclass : #ProtoObject,
	#instVars : [
		'layers'
	],
	#category : #'Moose-Algos-FormalConceptAnalysis'
}

{ #category : #'instance creation' }
MALattice class >> on: formalContext [
	
	^self new on: formalContext
]

{ #category : #displaying }
MALattice >> displayFigureOn: gc [
	
	| start |
	gc paint: Color gray.
	self children
		do:
			[:each | 
			start := each bounds bottomCenter.
			each children
				do:
					[:child | 
					gc
						displayLineFrom: start
						to: child bounds topCenter]]
]

{ #category : #'initialize-release' }
MALattice >> on: formalContext [
	
	formalContext concepts
		collect: [:each | self add: (MALatticeNode with: each)].
	layers := ((self children asArray groupedBy: #layer) associations sort:
			#key) collect: #value.
	layers size - 1
		to: 1
		by: -1
		do:
			[:n | 
			n + 1
				to: layers size
				do:
					[:m | 
					(layers at: n)
						do:
							[:each | (layers at: m) do: [:child | each maybeAppendChild: child]]]]
]

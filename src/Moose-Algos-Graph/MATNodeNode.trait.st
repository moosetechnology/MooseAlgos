Trait {
	#name : #MATNodeNode,
	#category : #'Moose-Algos-Graph'
}

{ #category : #accessing }
MATNodeNode >> from: sourceNode [

	self previousNodes add: sourceNode 
]

{ #category : #accessing }
MATNodeNode >> nextNodes [

	self explicitRequirement
]

{ #category : #accessing }
MATNodeNode >> previousNodes [

	self explicitRequirement
]

{ #category : #accessing }
MATNodeNode >> to: targetNode [

	self nextNodes add: targetNode 
]

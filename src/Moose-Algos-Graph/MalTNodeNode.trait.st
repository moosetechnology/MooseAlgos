Trait {
	#name : #MalTNodeNode,
	#category : #'Moose-Algos-Graph'
}

{ #category : #accessing }
MalTNodeNode >> from: sourceNode [

	self previousNodes add: sourceNode 
]

{ #category : #accessing }
MalTNodeNode >> nextNodes [

	self explicitRequirement
]

{ #category : #accessing }
MalTNodeNode >> previousNodes [

	self explicitRequirement
]

{ #category : #accessing }
MalTNodeNode >> to: targetNode [

	self nextNodes add: targetNode 
]

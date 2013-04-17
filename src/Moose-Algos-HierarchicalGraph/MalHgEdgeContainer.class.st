Class {
	#name : #MalHgEdgeContainer,
	#superclass : #Object,
	#instVars : [
		'relationships',
		'size'
	],
	#category : #'Moose-Algos-HierarchicalGraph'
}

{ #category : #adding }
MalHgEdgeContainer >> add: aSnRelationship [
	relationships add: aSnRelationship.
	size := size + 1.
]

{ #category : #adding }
MalHgEdgeContainer >> addAll: relationshipCollection [
	relationships addAll: relationshipCollection.
	size := size + (relationshipCollection size).
]

{ #category : #printing }
MalHgEdgeContainer >> description [
	^ size asString, ' Edges'.
]

{ #category : #'initialize-release' }
MalHgEdgeContainer >> initialize [ 
	relationships := Set new.
	size := 0.
]

{ #category : #printing }
MalHgEdgeContainer >> printOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPutAll: ' (';
		nextPutAll: size asString;
		nextPutAll: ')'.
]

{ #category : #removing }
MalHgEdgeContainer >> remove: aSnRelationship [
	relationships remove: aSnRelationship.
	size := size - 1.
]

{ #category : #removing }
MalHgEdgeContainer >> removeAll [
	relationships removeAll.
	size := 0.
]

{ #category : #accessing }
MalHgEdgeContainer >> size [
	^ size.
]

Class {
	#name : #MalHgEdgeContainer,
	#superclass : #Object,
	#instVars : [
		'size',
		'edges'
	],
	#category : #'Moose-Algos-HierarchicalGraph'
}

{ #category : #adding }
MalHgEdgeContainer >> add: anEdge [
	edges add: anEdge.
	size := size + 1.
]

{ #category : #adding }
MalHgEdgeContainer >> addAll: edgeCollection [
	edges addAll: edgeCollection.
	size := size + (edgeCollection size).
]

{ #category : #printing }
MalHgEdgeContainer >> description [
	^ size asString, ' Edges'.
]

{ #category : #'initialize-release' }
MalHgEdgeContainer >> initialize [ 
	edges := Set new.
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
MalHgEdgeContainer >> remove: anEdge [
	edges remove: anEdge.
	size := size - 1.
]

{ #category : #removing }
MalHgEdgeContainer >> removeAll [
	edges removeAll.
	size := 0.
]

{ #category : #accessing }
MalHgEdgeContainer >> size [
	^ size.
]

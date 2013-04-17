Class {
	#name : #MalHgEdge,
	#superclass : #MalHgEntityWrapper,
	#instVars : [
		'source',
		'destination'
	],
	#category : #'Moose-Algos-HierarchicalGraph'
}

{ #category : #'instance creation' }
MalHgEdge class >> with: anEntity source: srcNode destination: dstNode [
	| relationship |
	relationship:= MalHgEdge new.
	relationship entity: anEntity.
	relationship source: srcNode.
	relationship destination: dstNode.
	^ relationship.
]

{ #category : #accessing }
MalHgEdge >> destination [
	^ destination 


]

{ #category : #accessing }
MalHgEdge >> destination: aNode [
	destination := aNode.


]

{ #category : #accessing }
MalHgEdge >> printOn: aStream [
| src dst |
	src := self source entity name.
	dst := self destination entity name.
	aStream
		nextPutAll: 'Edge ';
		nextPutAll: src;
		nextPutAll: ' -> ';
		nextPutAll: dst.
]

{ #category : #accessing }
MalHgEdge >> source [
	^ source.

]

{ #category : #accessing }
MalHgEdge >> source: aNode. [
	source := aNode.

]

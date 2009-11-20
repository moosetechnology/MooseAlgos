"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MOValueItem,
	#superclass : #Association,
	#category : #'Moose-Algos-Clustering'
}

{ #category : #'distance functions' }
MOValueItem >> dist: anItem [
	
	^self value dist: anItem value
]

{ #category : #accessing }
MOValueItem >> item [
	
	^self key
]

{ #category : #accessing }
MOValueItem >> item: anObject [
	
	^self key: anObject
]

{ #category : #'distance functions' }
MOValueItem >> similarity: anItem [
	
	^self value similarity: anItem value
]

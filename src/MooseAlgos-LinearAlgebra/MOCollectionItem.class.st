"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MOCollectionItem,
	#superclass : #Collection,
	#instVars : [
		'item',
		'collection'
	],
	#category : #'MooseAlgos-Clustering'
}

{ #category : #adding }
MOCollectionItem >> add: newObject [
	" *** This method was defined by Collection as a subclass responsibility.
	Replace its body with a proper implementation. *** "
	
	self error: 'Subclass responsibility stub not reimplemented'
]

{ #category : #accessing }
MOCollectionItem >> collection [
	
	^collection
]

{ #category : #accessing }
MOCollectionItem >> collection: anObject [
	
	collection := anObject
]

{ #category : #enumerating }
MOCollectionItem >> do: aBlock [
	" *** This method was defined by Collection as a subclass responsibility.
	Replace its body with a proper implementation. *** "
	
	self error: 'Subclass responsibility stub not reimplemented'
]

{ #category : #accessing }
MOCollectionItem >> item [
	
	^item
]

{ #category : #accessing }
MOCollectionItem >> item: anObject [
	
	item := anObject
]

{ #category : #removing }
MOCollectionItem >> remove: oldObject ifAbsent: anExceptionBlock [
	" *** This method was defined by Collection as a subclass responsibility.
	Replace its body with a proper implementation. *** "
	
	self error: 'Subclass responsibility stub not reimplemented'
]

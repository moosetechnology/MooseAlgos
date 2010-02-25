Class {
	#name : #MAMedianAccumulator,
	#superclass : #Object,
	#instVars : [
		'values'
	],
	#category : #'Moose-Algos-LinearAlgebra'
}

{ #category : #'instance creation' }
MAMedianAccumulator class >> new [
	
	^self basicNew initialize
]

{ #category : #'instance creation' }
MAMedianAccumulator class >> withAll: aCollection [
	
	^(self new)
		addAll: aCollection;
		yourself
]

{ #category : #accumulating }
MAMedianAccumulator >> add: value [
	
	values add: value
]

{ #category : #accumulating }
MAMedianAccumulator >> addAll: aCollection [
	
	values addAll: aCollection
]

{ #category : #accessing }
MAMedianAccumulator >> bottom [
	
	^values last
]

{ #category : #accessing }
MAMedianAccumulator >> firstQuartil [
	
	^values at: (values size / 4) asInteger
]

{ #category : #'initialize-release' }
MAMedianAccumulator >> initialize [
	
	values := SortedCollection new
]

{ #category : #accessing }
MAMedianAccumulator >> median [
	
	^values at: (values size / 2) asInteger
]

{ #category : #printing }
MAMedianAccumulator >> printOn: aStream [
	
	aStream
		nextPutAll: 'Median = ';
		print: self median;
		space;
		nextPut: $(;
		print: self top;
		nextPut: $;;
		space;
		print: self firstQuartil;
		nextPut: $;;
		space;
		print: self median;
		nextPut: $;;
		space;
		print: self thirdQuartil;
		nextPut: $;;
		space;
		print: self bottom;
		nextPut: $)
]

{ #category : #accessing }
MAMedianAccumulator >> thirdQuartil [
	
	^values at: (values size / 4 * 3) asInteger
]

{ #category : #accessing }
MAMedianAccumulator >> top [
	
	^values first
]

{ #category : #accumulating }
MAMedianAccumulator >> value: value [
	
	values add: value
]

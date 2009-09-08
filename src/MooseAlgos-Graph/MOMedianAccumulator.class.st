Class {
	#name : #MOMedianAccumulator,
	#superclass : #Object,
	#instVars : [
		'values'
	],
	#category : #'MooseAlgos-LinearAlgebra'
}

{ #category : #'instance creation' }
MOMedianAccumulator class >> new [
	
	^self basicNew initialize
]

{ #category : #'instance creation' }
MOMedianAccumulator class >> withAll: aCollection [
	
	^(self new)
		addAll: aCollection;
		yourself
]

{ #category : #accumulating }
MOMedianAccumulator >> add: value [
	
	values add: value
]

{ #category : #accumulating }
MOMedianAccumulator >> addAll: aCollection [
	
	values addAll: aCollection
]

{ #category : #accessing }
MOMedianAccumulator >> bottom [
	
	^values last
]

{ #category : #accessing }
MOMedianAccumulator >> firstQuartil [
	
	^values at: (values size / 4) asInteger
]

{ #category : #'initialize-release' }
MOMedianAccumulator >> initialize [
	
	values := SortedCollection new
]

{ #category : #accessing }
MOMedianAccumulator >> median [
	
	^values at: (values size / 2) asInteger
]

{ #category : #printing }
MOMedianAccumulator >> printOn: aStream [
	
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
MOMedianAccumulator >> thirdQuartil [
	
	^values at: (values size / 4 * 3) asInteger
]

{ #category : #accessing }
MOMedianAccumulator >> top [
	
	^values first
]

{ #category : #accumulating }
MOMedianAccumulator >> value: value [
	
	values add: value
]

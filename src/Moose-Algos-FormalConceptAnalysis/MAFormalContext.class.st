Class {
	#name : #MAFormalContext,
	#superclass : #Object,
	#instVars : [
		'fobjects',
		'fattributes',
		'concepts'
	],
	#category : #'Moose-Algos-FormalConceptAnalysis'
}

{ #category : #examples }
MAFormalContext class >> benchmark [
	
	| all |
	[all := (self classHierarchy: Core allClasses , SCG allClasses) concepts]
		profile.
	all inspect
]

{ #category : #examples }
MAFormalContext class >> classHierarchy [
	
	^self classHierarchy: Smalltalk allClasses
]

{ #category : #examples }
MAFormalContext class >> classHierarchy: classes [
	
	| fca |
	fca := MAFormalContext new.
	fca
		with: classes
		using: #yourself
		using: [:each | each allSelectors "\"difference: Object allSelectors].
	^fca
]

{ #category : #examples }
MAFormalContext class >> mammals [
	"(((		self mammals			)))"
	
	| data names fca |
	data := #(#(#ostrich #(#walks #laysEggs #featheres #warmblooded)) #(#mosquito #(#laysEggs #flies #small)) #(#vulture #(#laysEggs #featheres #warmblooded #flies)) #(#horse #(#walks #warmblooded #suckles)) #(#bat #(#warmblooded #flies #small #suckles)) #(#frog #(#quacks #laysEggs #small)) #(#dove #(#laysEggs #featheres #warmblooded #flies #small)) #(#crocodile #(#walks #laysEggs)) #(#robin #(#laysEggs #featheres #warmblooded #flies #sings #small)) #(#platypus #(#walks #laysEggs #warmblooded #suckles))).
	names := #(#robin #dove #vulture #ostrich #bat #horse #platypus #crocodile #frog #mosquito).
	names := String withAll: (names collect: #first).
	fca := MAFormalContext new.
	fca with: data using: #first using: #last.
	^fca
]

{ #category : #examples }
MAFormalContext class >> mammals2 [
	"(((		self mammals2			)))"
	
	| data fca |
	data := #(#(#Cat #(#fourlegs #hair)) #(#Dog #(#fourlegs #hair)) #(#Dolphin #(#smart #marine)) #(#Gibbon #(#hair #smart #thumbed)) #(#Man #(#smart #thumbed)) #(#Whale #(#smart #marine))).
	fca := MAFormalContext new.
	fca with: data using: #first using: #last.
	^fca
]

{ #category : #accessing }
MAFormalContext >> attributes [
	
	^fattributes
]

{ #category : #private }
MAFormalContext >> computeConcepts [
	
	| algorithm |
	algorithm := MAGanterAlgorithm on: self.
	^algorithm allConcepts
]

{ #category : #accessing }
MAFormalContext >> concepts [
	
	^concepts ifNil: [concepts := self computeConcepts]
]

{ #category : #accessing }
MAFormalContext >> objects [
	
	^fobjects
]

{ #category : #printing }
MAFormalContext >> printOn: stream [
	
	super printOn: stream.
	stream
		space;
		nextPut: $(;
		print: self objects size;
		nextPut: $?ó;
		print: self attributes size;
		nextPut: $)
]

{ #category : #'initialize-release' }
MAFormalContext >> with: collection using: foBlock using: faBlock [
	
	| dict fobject fattribute |
	dict := Dictionary new.
	fobjects := "ArrayList"OrderedCollection new.
	fattributes := "ArrayList"OrderedCollection new.
	collection
		do:
			[:eachFo | 
			fobject := MAFCAElement with: (foBlock value: eachFo).
			fobject appendTo: fobjects.
			(faBlock value: eachFo)
				do:
					[:eachFa | 
					fattribute := dict
						at: eachFa
						ifAbsentPut:
							[fattribute := MAFCAElement with: eachFa.
							fattribute appendTo: fattributes].
					fattribute setBit: fobject.
					fobject setBit: fattribute]]
]

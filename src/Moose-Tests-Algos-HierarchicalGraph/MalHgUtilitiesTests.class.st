Class {
	#name : #MalHgUtilitiesTests,
	#superclass : #TestCase,
	#category : #'Moose-Tests-Algos-HierarchicalGraph'
}

{ #category : #tests }
MalHgUtilitiesTests >> testLinearGrowthEquation [ 
	| util eq |
	util := MalHgUtilities instance.
	eq := util linearGrowthEquation: 0@100 sizeExtrema: 0@100.
	self assert: ((eq value: 50) = 50).
	self assert: ((eq value: 75) = 75).
	self assert: ((eq value: 0) = 0).
	self assert: ((eq value: 100) = 100).
	self assert: ((eq value: -1) = 0).
	self assert: ((eq value: 200) = 100).
	
	eq := util linearGrowthEquation: 0@100 sizeExtrema: 0@2000.
	self assert: ((eq value: 50) = 1000).
	self assert: ((eq value: 75) = 1500).
	self assert: ((eq value: 0) = 0).
	self assert: ((eq value: 100) = 2000).
	self assert: ((eq value: -1) = 0).
	self assert: ((eq value: 200) = 2000).
	
	eq := util linearGrowthEquation: -20.4@102 sizeExtrema: -100@2240.
	self assert: ((eq value: 50) = 1245.882).
	self assert: ((eq value: 75) = 1723.824).
	self assert: ((eq value: 0) = 290.0).
	self assert: ((eq value: 102) = 2240).
	self assert: ((eq value: -1) = 270.882).
	self assert: ((eq value: 200) = 2240).
	self assert: ((eq value: -20.4) = -100). 
	
	eq := util linearGrowthEquation: -20@50 sizeExtrema: 0@100.
	self assert: ((eq value: -20) = 0).
	self assert: ((eq value: 10) = 42.857).
	self assert: ((eq value: 0) = 28.571).
	self assert: ((eq value: 50) = 100).
]

{ #category : #tests }
MalHgUtilitiesTests >> testLinearGrowthEquationSquared [
	| util eq |
	util := MalHgUtilities instance.
	eq := util linearGrowthEquationSquared: 0@100 sizeExtrema: 0@100.
	self assert: ((eq value: 50) = 50).
	self assert: ((eq value: 75) = 75).
	self assert: ((eq value: 0) = 0).
	self assert: ((eq value: 100) = 100).
	self assert: ((eq value: -1) = 0).
	self assert: ((eq value: 200) = 100).
	
	eq := util linearGrowthEquationSquared: 0@100 sizeExtrema: 0@2000.
	self assert: ((eq value: 50) = 1000).
	self assert: ((eq value: 75) = 1500).
	self assert: ((eq value: 0) = 0).
	self assert: ((eq value: 100) = 2000).
	self assert: ((eq value: -1) = 0).
	self assert: ((eq value: 200) = 2000).

]

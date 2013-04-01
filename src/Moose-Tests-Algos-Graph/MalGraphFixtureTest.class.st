Class {
	#name : #MalGraphFixtureTest,
	#superclass : #TestCase,
	#category : #'Moose-Tests-Algos-Graph'
}

{ #category : #tests }
MalGraphFixtureTest >> testSimpleGraph [

	self shouldnt: [ (MalGraphFixture view: #simpleGraph:) delete ] raise: Error.
	self shouldnt: [ (MalGraphFixture view: #cycleGraph:) delete ] raise: Error.
	self shouldnt: [ (MalGraphFixture view: #aseCircuitGraph:) delete ] raise: Error.
	self shouldnt: [ (MalGraphFixture view: #moduleGraph:) delete ] raise: Error.
	self shouldnt: [ (MalGraphFixture view: #nestedCycleGraph:) delete ] raise: Error.
]

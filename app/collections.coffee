@Cards = new Mongo.Collection "Cards"
@Cards.States = 
	todo:
		value: "todo", label: "Todo", icon: "glyphicon-pause"
	"in-progress":
		value: "in-progress", label: "In progress", icon: "glyphicon-play"
	done:
		value: "done", label: "Done", icon: "glyphicon-ok"
@Cards.attachSchema new SimpleSchema
	title:
		label: "Title"
		type: String
	description:
		label: "Description"
		type: String
		autoform:
			rows: 8
	estimate: 
		label: "Estimate"
		type: Number
		allowedValues: [1,2,3,5,8]
	
	responsible: 
		label: "Responsible person"
		type: String
	state:
		label: "State"
		type: String
		allowedValues: _.map @Cards.States, (state) -> state.value
		autoform:
			options: _.values @Cards.States
		defaultValue: "todo"

@Cards.SAMPLE =
	_id: "sample"
	title: "As a user, i want to create new cards"
	description: "The user should be able to create new story cards"
	estimate: 3
	responsible: "Marco"
	state: "todo"
@Cards.SAMPLE_IN_PROGRESS =
	_id: "sample-in-progress"
	title: "As a user, i want to create new cards"
	description: "The user should be able to create new story cards"
	estimate: 3
	responsible: "Marco"
	state: "in-progress"
@Cards.SAMPLE_DONE =
	_id: "sample-done"
	title: "As a user, i want to create new cards"
	description: "The user should be able to create new story cards"
	estimate: 3
	responsible: "Marco"
	state: "done"

describe "Scrumboard", ->
	describe "columns", ->
		beforeEach ->
			Cards.find().forEach (card) ->
				Cards.remove card._id

		describe "column-todo", ->
			it "should have a column for Todo", ->
				$column = $ ".scrumboard .column-todo"
				expect($column.length).toBe 1

			it "should have a title 'Todo'", ->
				$title = $ ".scrumboard .column-todo > .title"
				expect($title.text()).toContain "Todo"
			it "shows cards with state 'todo'", ->
				Cards.insert Cards.SAMPLE
				Tracker.flush()
				share.TestHelpers.checkColumnForSampleCard $ ".scrumboard .column-todo ul.cards"
				


		describe "column-in-progress", ->
			it "should have a column for in-progress", ->
				$column = $ ".scrumboard .column-in-progress"
				expect($column.length).toBe 1
			it "should have a title 'In progress'", ->
				$title = $ ".scrumboard .column-in-progress > .title"
				expect($title.text()).toContain "In progress"

			it "shows cards with state 'in-progress'", ->
				card = Cards.SAMPLE
				card.state ="in-progress"
				Cards.insert card
				Tracker.flush()
				share.TestHelpers.checkColumnForSampleCard $ ".scrumboard .column-in-progress ul.cards"
		
		describe "column-done", ->
			it "should have a column for done", ->
				$column = $ ".scrumboard .column-done"
				expect($column.length).toBe 1
			it "should have a title 'Done'", ->
				$title = $ ".scrumboard .column-done > .title"
				expect($title.text()).toContain "Done"

			it "shows cards with state 'done'", ->
				card = Cards.SAMPLE
				card.state ="done"
				Cards.insert card
				Tracker.flush()
				share.TestHelpers.checkColumnForSampleCard $ ".scrumboard .column-done ul.cards"

	

		

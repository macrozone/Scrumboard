describe "Scrumboard", ->
	describe "Card", ->
		$card = null
		$cardInProgress = null
		$cardDone = null
		beforeEach ->
			Cards.find().forEach (card) ->
				Cards.remove card._id
			Cards.insert Cards.SAMPLE
			Cards.insert Cards.SAMPLE_IN_PROGRESS
			Cards.insert Cards.SAMPLE_DONE
			
			Tracker.flush()
			$card = $ ".scrumboard .column-todo ul.cards .card"
			$cardInProgress = $ ".scrumboard .column-in-progress ul.cards .card"
			$cardDone = $ ".scrumboard .column-done ul.cards .card"
			
		

		it "shows title", ->
			expect $card.find(".title").text()
			.toBe Cards.SAMPLE.title
		it "shows description", ->
			expect $card.find(".description").text()
			.toBe Cards.SAMPLE.description
		it "shows estimate", ->
			expect $card.find(".estimate").text()
			.toBe Cards.SAMPLE.estimate.toString()
		it "shows responsible", ->
			expect $card.find(".responsible").text()
			.toBe Cards.SAMPLE.responsible
		it "is draggable", ->
			expect $card.prop "draggable"
			.toBe true
		it "has an edit button", ->
			expect $card.find(".btn-edit").length
			.toBe 1
		it "has a delete button", ->
			expect $card.find(".btn-delete").length
			.toBe 1
				
		describe "delete button", ->
			it "deletes the card on click", ->
				$card.find(".btn-delete").trigger "click"
				Tracker.flush()
				expect Cards.findOne Cards.SAMPLE._id
				.not.toBeDefined()
			it "deletes no other card on click", ->
				$card.find(".btn-delete").trigger "click"
				Tracker.flush()
				expect Cards.findOne Cards.SAMPLE_IN_PROGRESS._id
				.toBeDefined()
				expect Cards.findOne Cards.SAMPLE_DONE._id
				.toBeDefined()
		describe "edit button", ->
			it "shows edit form on the card when clicked", ->
				$card.find(".btn-edit").trigger "click"
				Tracker.flush()
				expect $card.find(".edit-form").length
				.toBe 1
			it "fills out the form with data from the card", ->
				$card.find(".btn-edit").trigger "click"
				Tracker.flush()
				$form = $card.find(".edit-form")
				expect $form.find("[name='title']").val()
				.toBe Cards.SAMPLE.title
				expect $form.find("[name='description']").val()
				.toBe Cards.SAMPLE.description
				expect $form.find("[name='responsible']").val()
				.toBe Cards.SAMPLE.responsible
				expect parseInt $form.find("[name='estimate']").val(),10
				.toBe Cards.SAMPLE.estimate


			it "hides edit form when clicked on cancel on the form", ->
				$card.find(".btn-edit").trigger "click"
				Tracker.flush()
				$card.find(".btn-cancel").trigger "click"
				Tracker.flush()
				expect $card.find(".edit-form").length
				.toBe 0
			it "does not save changes on card when clicked on cancel", ->
				$card.find(".btn-edit").trigger "click"
				Tracker.flush()
				$form = $card.find(".edit-form")
				$form.find("[name='title']").val "my new title"
				$card.find(".btn-cancel").trigger "click"
				Tracker.flush()
				expect $card.find(".title").text()
				.toBe Cards.SAMPLE.title
			it "hides edit form when clicked on submit on the form", (done)->
				$card.find(".btn-edit").trigger "click"
				Tracker.flush()
				$card.find(".edit-form").submit()
				Tracker.flush()
				Meteor.setTimeout -> # this is not totally deterministic, problem is that autoform does some additional event-loop-circles
					Tracker.flush()
					expect $card.find(".edit-form").length
					.toBe 0
					done()
				,500

			it "saves changes on card when clicked on submit", (done)->
				$card.find(".btn-edit").trigger "click"
				Tracker.flush()
				$form = $card.find(".edit-form")
				$form.find("[name='title']").val "my new title"
				$form.find("[name='description']").val "my new description"
				$form.find("[name='estimate']").val 5
				$form.find("[name='responsible']").val "my new responsible"
				$form.submit()
	
				Tracker.flush()
				Meteor.defer ->
					expect $card.find(".title").text()
					.toBe "my new title"
					expect $card.find(".description").text()
					.toBe "my new description"
					expect $card.find(".estimate").text()
					.toBe "5"
					expect $card.find(".responsible").text()
					.toBe "my new responsible"
					done()

		describe "card-todo", ->
			it "shows button to select done or in-progress", ->
				expect($card.find(".btn-state-todo").length).toBe 0
				expect($card.find(".btn-state-in-progress").length).toBe 1
				expect($card.find(".btn-state-done").length).toBe 1
				
		describe "card-in-progress", ->
			it "shows button to select todo or done", ->
				expect($cardInProgress.find(".btn-state-todo").length).toBe 1
				expect($cardInProgress.find(".btn-state-in-progress").length).toBe 0
				expect($cardInProgress.find(".btn-state-done").length).toBe 1
		describe "card-done", ->
			it "shows button to select todo or in-progress", ->
				expect($cardDone.find(".btn-state-todo").length).toBe 1
				expect($cardDone.find(".btn-state-in-progress").length).toBe 1
				expect($cardDone.find(".btn-state-done").length).toBe 0



			
			


		

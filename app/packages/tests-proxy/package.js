Package.describe({
	name: "velocity:test-proxy",
	summary: "Dynamically created package to expose test files to mirrors",
	version: "0.0.4",
	debugOnly: true
});

Package.onUse(function (api) {
	api.use("coffeescript", ["client", "server"]);
	api.add_files("tests/jasmine/client/integration/Scrumboard.card.Spec.coffee",["client"]);
	api.add_files("tests/jasmine/client/integration/Scrumboard.columns.Spec.coffee",["client"]);
	api.add_files("tests/jasmine/client/integration/Scrumboard.form.Spec.coffee",["client"]);
	api.add_files("tests/jasmine/client/integration/TestHelpers.coffee",["client"]);
});
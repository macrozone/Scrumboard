# Scrumboard
Scrumboard - little project for ZHAW

## Api

### DDP (Highlevel, Live-Data)

You can connect with DDP to the app to get cards. There are multiple ddp implementations (meteor, node, java, ruby, ...)

Meteor example:
```javascript
  var connection = DDP.connect("scrumboard.macrozone.ch");
  var Cards = new Mongo.Collection("cards", connection);
  connection.subscribe("cards");
  // now you have cards in your "cards" collection
```
See https://github.com/macrozone/Scrumboard/blob/master/app/collections.coffee for the schema

### REST (lowlevel)

There are the following routes (CRUDL):
```
  GET     /api/cards
  GET     /api/cards/:id
  POST    /api/cards/:id
  PUT     /api/cards/:id
  DELETE  /api/cards/:id
```
See https://github.com/macrozone/Scrumboard/blob/master/app/collections.coffee for the schema (json)

## install

1. Install meteor `curl https://install.meteor.com/ | sh`
2. checkout project and `cd app; meteor`
3. ????
4. profit


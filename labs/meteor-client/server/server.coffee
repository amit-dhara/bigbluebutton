###
Meteor.startup(function () {
  // Add seed data if first time server starting
  CreateSeedData();

  // Publish data collections
  PublishCollections();

  // Set collection permissions
  SetCollectionPermissions();

});
###
Meteor.methods
  # If we can change this to a format where we know what to send the user that'd
  # be much, much better than the user passing in the first part of their
  # credentials and us looking up and suplying them with the second part.
  # It'd be much more secure.
  getMyInfo: (uId) ->
    u = Meteor.Users.findOne("userId": uId)
    if u?
      {
        userId: u.userId
        DBID: u._id
        name: u.user.name
      }

Meteor.startup ->
  console.log "server start"
  
  #remove all data
  clearCollections()

  # create create a PubSub connection, start listening
  Meteor.redisPubSub = new Meteor.RedisPubSub(->
    console.log "created pubsub")

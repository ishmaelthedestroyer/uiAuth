define [
  'SessionSVC'
], () ->
  (options) ->
    ['$q', '$state', 'Session', ($q, $state, Session) ->
      deferred = $q.defer()

      Session.load().then (session) ->
        if options.reqAuth
          if !session? or !Object.getOwnPropertyNames(session).length
            deferred.reject null
            $state.go options.reqAuth
        else if options.redirAuth
          if session and Object.getOwnPropertyNames(session).length
            deferred.reject null
            $state.go options.redirAuth
        else
          deferred.resolve true

      deferred.promise
    ]
uiAuth
======

Simple authentication and client-side sessions for AngularJs apps using ui-router. It's completely backend-agnostic - just point the SessionSVC to a login API, hook it up to a controller, link the uiAuth to your states for authentication, and you're ready to go.

###Usage
This plugin works great with RequireJs (http://requirejs.org/).

In your RequireJs main file, define the SessionSVC + uiAuth scripts as well as their locations. When configuring your states, add any key to your resolve object and use the uiAuth function as its value. It takes an object as a parameter with the values reqAuth and redirLogin, either false or the state to redirect to depending on the session's state. Configuration might look like this (Coffeescript):

`main.js`
<pre>
require.config
    angular: '/path/to/angular'
    app: '/path/to/app'
    SessionSVC: '/path/to/SessionSVC'
    uiAuth: '/path/to/uiAuth'
</pre>

`app.js`
<pre>
define [
  'angular'
], (angular) ->
  'use strict'
  app = angular.module 'App', []
  angular.bootstrap document, 'App'

  return app
</pre>

`routes.js`
<pre>
define [
    'app'
    'uiAuth'
], (app) ->
  app.config ($stateProvider, $urlRouterProvider, $locationProvider) ->
    $stateProvider.state 'some-secure-state',
        url: '/some-secure-route'
        templateUrl: '/path/to/some-secure-route.html'
        resolve:
            uiAuth: uiAuth
                reqAuth: 'login'
                redirLogin: false
    $stateProvider.state 'login',
        url: '/login'
        templateUrl: '/path/to/login.html'
        resolve:
            uiAuth: uiAuth
                reqAuth: false
                redirLogin: 'some-secure-state'
</pre>

The uiAuth script will check the Session service in the SessionSVC script. The Session service can be configured for your own usage. It'll provide these functions out-of-the-box:

`Session.load()`
`Session.refresh()`
`Session.isAuthenticated()`
`Session.login()`
`Session.logout()`

All of them respond asynchronously using the promise library, so use accordingly. More updates and documentation to come soon.

###Notes
Developed by <a href='http://twitter.com/ishmaelsalive'>Ishmael tD</a>. <br />

Feedback, suggestions? Tweet me <a href='http://twitter.com/ishmaelsalive'>@IshmaelsAlive</a>. <br />
Need some personal help? Email me @ <a href='mailto:ishmaelthedestroyer@gmail.com?Subject=LazyNMean'>ishmaelthedestroyer@gmail.com</a>
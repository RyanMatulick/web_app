import React, { Component } from 'react'
import { Switch, Route } from 'react-router-dom'
import WebsiteIndex from 'components/websites/index'
import UserDetail from 'components/websites/detail'
import NoMatch from 'components/no_match'


export default class Body extends Component {
  
  render() {
    return(
      <div className="container">
        <Switch>
          <Route exact path='/miracles' component={WebsiteIndex} />
          <Route exact path='/miracles/:userId' component={UserDetail} />
          <Route path='*' component={NoMatch} status={404}/>
        </Switch>
      </div>
    )
  }
}
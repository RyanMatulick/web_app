import React, { Component } from 'react'
import { Route } from 'react-router-dom'
import Header from 'components/header'
import Body from 'components/body'

export default class MiraclesApp extends Component {
  
  render() {
    return(
      <div className="miracles">
        <Route path='/miracles' component={Header} />
        <Body />
      </div>
    )
  }
}
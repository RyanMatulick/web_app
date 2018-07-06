import React, { Component } from 'react'

export default class NoMatch extends Component {

  render() {
    return(
      <div className="container no-match">
        <h1>Oops, an error occurred!</h1>
        <p>The page you are looking for cannot be found.</p>
      </div>
    )
  }
}
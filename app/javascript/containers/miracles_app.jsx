import React, { Component } from 'react'
import { BrowserRouter } from 'react-router-dom'
import MiraclesApp from 'apps/miracles'
import renderWithContext from './application_context'

export default class MiraclesAppWithContext extends Component {
  render() {
    return renderWithContext(
      <BrowserRouter>
        <MiraclesApp {...this.props} />
      </BrowserRouter>
    )
  }
}
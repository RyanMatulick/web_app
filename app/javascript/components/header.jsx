import React, { Component } from 'react'
import { connect } from 'react-redux'
//import dcLogo from 'app/assets/images/dc_logo_horiz.png'
import { withRouter, Link } from 'react-router-dom'

export class Header extends Component {

  render() {
    return(
      <header>
        <nav className="nav navbar fixed-top navbar-toggleable-md navbar-dark">
          <div className="container-fluid">
            <div className="navbar-header">
              <h1>HEADER THING</h1>
            </div>
          </div>
        </nav>
      </header>
    )
  }
}

const mapStateToProps = () => {
  return {
  }
}

const mapDispatchToProps = {}

export default withRouter(connect(mapStateToProps, mapDispatchToProps)(Header))

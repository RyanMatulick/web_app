import React, { Component } from 'react'
import { connect } from 'react-redux'
//import dcLogo from 'app/assets/images/dc_logo_horiz.png'
import { withRouter, Link } from 'react-router-dom'
import { Tooltip, Button } from 'reactstrap';

export class Header extends Component {

  render() {
    const { history } = this.props
    return(
      <header>
        <nav className="nav navbar fixed-top navbar-toggleable-md navbar-dark">
          <div className="container-fluid">
            <div className="navbar-header">
              <h1>HEADER THING</h1>
              <Button id={ 'Tooltip' } className={ "index-icon link-icon" } color="Link" onClick={ () => { history.push(`/`) }}>BIG BUTTON</Button>
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

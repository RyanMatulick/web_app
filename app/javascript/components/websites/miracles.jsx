import React, { Component } from 'react'
import { bindActionCreators } from 'redux'
import { connect } from 'react-redux'
import { withRouter } from 'react-router-dom'

export class WebsiteIndex extends Component {
  proptypes = {}

  render() {
    return(
      <div className="test div">
        <h1>PLEASE WORK</h1>
      </div>
    )
  }
}

const mapStateToProps = (state) => ({
})

const mapDispatchToProps = dispatch => {
  return bindActionCreators(
    { },
    dispatch
  )
}

export default withRouter(connect(mapStateToProps, mapDispatchToProps)(WebsiteIndex))


import React, { Component } from 'react'
import PropTypes from 'prop-types'
import { bindActionCreators} from 'redux'
import { connect } from 'react-redux'
import { withRouter } from 'react-router-dom'
import { Container } from 'reactstrap'
import { fetchUserDetail } from 'actions/users'

export class UserDetail extends Component {
  static propTypes = {
    userId: PropTypes.number.isRequired,
    fetchUserDetail: PropTypes.func.isRequired
  }

  constructor(props){
    super(props)
    this.state = {
        userDetail: {}
    }
}

  componentDidMount() {
    const { fetchUserDetail, userId } = this.props
    fetchUserDetail(userId).then(response => {
      console.log(response)
      this.setState({
        userDetail: response
      })
    })
  }

  render() {
    const { userDetail } = this.state
    console.log('in Render')
    console.log(userDetail)
    return(
      <div>
        <h1>User Detail</h1>
        <p>{userDetail.title} {userDetail.name}</p>
      </div>
    )
  }
}

export const mapStateToProps = (state, props) => { 
  console.log(state)
  const userId = parseInt(props.match.params.userId, 10)
  return {    
    userId,
  }
}

const mapDispatchToProps = dispatch => bindActionCreators({ fetchUserDetail }, dispatch)

export default withRouter(connect(mapStateToProps, mapDispatchToProps)(UserDetail))

import React, { Component } from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'
import { withRouter } from 'react-router-dom'
import { bindActionCreators } from 'redux'
import { reduxForm } from 'redux-form'

import { Card, CardColumns, CardImg, CardText, CardBody, CardTitle, CardSubtitle, Button } from 'reactstrap';
import { fetchUserDetail } from 'actions/users';

export class WebsiteIndex extends Component {
  proptypes = {
    id: PropTypes.number.isRequired,
    userDetail: PropTypes.object.isRequired,
    fetchUserDetail: PropTypes.func.isRequired
  }

  constructor(props) {
    super(props);
    this.state = { }
  }

  componentDidMount(){
    const { id } = this.props
    this.fetchUserDetail(1)
  }

  componentWillReceiveProps(nextProps) {
    if (1 !== 1) {
      this.fetchUserDetail(1)
    }
  }

  fetchUserDetail(websiteId) {
    const { fetchUserDetail } = this.props
    fetchUserDetail(websiteId).then(() => {
    })
  }

  render() {
    const { history } = this.props
    return(
      <div className="website-index container-fluid">
        <h1>PLEASE WORK</h1>
        <Button id={ 'Tooltip' } className={ "index-icon link-icon" } color="Link" onClick={ () => { history.push(`miracles/users`) }}>BIG BUTTON</Button>
        <CardColumns>
          <Card>
            <CardImg top width="100%" src="https://placeholdit.imgix.net/~text?txtsize=33&txt=256%C3%97180&w=256&h=180" alt="Card image cap" />
            <CardBody>
              <CardTitle>Card title</CardTitle>
              <CardSubtitle>Card subtitle</CardSubtitle>
              <CardText>This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</CardText>
              <Button>Button</Button>
            </CardBody>
          </Card>
          <Card>
            <CardImg top width="100%" src="https://placeholdit.imgix.net/~text?txtsize=33&txt=256%C3%97180&w=256&h=180" alt="Card image cap" />
          </Card>
          <Card>
            <CardBody>
              <CardTitle>Card title</CardTitle>
              <CardSubtitle>Card subtitle</CardSubtitle>
              <CardText>This card has supporting text below as a natural lead-in to additional content.</CardText>
              <Button>Button</Button>
            </CardBody>
          </Card>
          <Card body inverse style={{ backgroundColor: '#333', borderColor: '#333' }}>
            <CardTitle>Special Title Treatment</CardTitle>
            <CardText>With supporting text below as a natural lead-in to additional content.</CardText>
            <Button>Button</Button>
          </Card>
          <Card>
            <CardImg top width="100%" src="https://placeholdit.imgix.net/~text?txtsize=33&txt=256%C3%97180&w=256&h=180" alt="Card image cap" />
            <CardBody>
              <CardTitle>Card title</CardTitle>
              <CardSubtitle>Card subtitle</CardSubtitle>
              <CardText>This is a wider card with supporting text below as a natural lead-in to additional content. This card has even longer content than the first to show that equal height action.</CardText>
              <Button>Button</Button>
            </CardBody>
          </Card>
          <Card body inverse color="primary">
            <CardTitle>Special Title Treatment</CardTitle>
            <CardText>With supporting text below as a natural lead-in to additional content.</CardText>
            <Button color="secondary">Button</Button>
          </Card>
        </CardColumns>
      </div>
    )
  }
}

const mapStateToProps = (state) => {
  console.log(state)
  return{
    Users: state
  }
}

const mapDispatchToProps = dispatch => bindActionCreators({ fetchUserDetail }, dispatch)

export const WebsiteIndexWithRedux = connect(mapStateToProps, mapDispatchToProps)(WebsiteIndex)
export const REDUX_FORM_NAME = 'WebsiteIndex'


export default withRouter(reduxForm({form: REDUX_FORM_NAME})(WebsiteIndexWithRedux))


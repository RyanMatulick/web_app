import {
  FETCH_USER_DETAIL_RESPONSE 
} from 'actions/users'

const initialState = { 
  searchText: '',
  sortColumn: 'name_case_insensitive asc',
  list: [],
  count: 0,
  details: {}
}

export default (state = initialState, action) => {
  switch(action.type) {

    case FETCH_USER_DETAIL_RESPONSE:
      return {
        ...state,
        details: {
          ...state.details,
          [10]: action
        }
      }

    default:
      return state
  }
}
import { createStore, combineReducers } from 'redux';
import { reducer as formReducer } from 'redux-form';
import { reducer as searchReducer } from 'redux-search'
import appReducer from './app'

const reducers = {
  app: appReducer
}
const reducer = combineReducers(reducers);
export default reducer;

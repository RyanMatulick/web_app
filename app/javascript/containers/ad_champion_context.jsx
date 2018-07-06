import React from 'react';
import { createStore, applyMiddleware, compose } from 'redux'
import { reduxSearch } from 'redux-search'
import { Provider } from 'react-redux';
import thunk from 'redux-thunk'
import { createLogger } from 'redux-logger'
import reducer from 'reducers';

const middleware = [ thunk ]
if (process.env.NODE_ENV !== 'production') {
  middleware.push(createLogger());
}


const composeEnhancers = window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ || compose;
const store = createStore(
  reducer,
  composeEnhancers(
    applyMiddleware(...middleware),
    reduxSearch({
      // Configure redux-search by telling it which resources to index for searching
      resourceIndexes: {},
      // This selector is responsible for returning each collection of searchable resources
      resourceSelector: (resourceName, state) => {
        var parts = resourceName.split('.')
        var resource = state
        parts.forEach(p => { resource = resource[p] })        
        return resource
      }
    })
  )
);

const renderWithContext = (child) => {
  return(
    <Provider store={store}>
      {child}
    </Provider>
  );
}

export default renderWithContext;
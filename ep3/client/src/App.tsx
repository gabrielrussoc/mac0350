import React, { Fragment } from 'react';
import { BrowserRouter as Router, Route } from 'react-router-dom';

import Home from './Home'
import Login from './Login'

const App = () => (
  <Router>
    <Fragment>
      <Route exact path="/" component={Home} />
      <Route path="/login" component={Login} />
    </Fragment>
  </Router>
);

export default App;

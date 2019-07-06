import React, { Fragment } from 'react';
import { BrowserRouter as Router, Route } from 'react-router-dom';

import Curriculums from './Curriculums'
import Login from './Login'

const App = () => (
  <Router>
    <Fragment>
      <Route exact path="/" component={Curriculums} />
      <Route path="/login" component={Login} />
      <Route path="/cadastro" component={Login} />
      <Route path="/curriculo/:curriculumId/disciplinas" component={Login} />
      <Route path="/curriculo/:curriculumId/trilhas" component={Login} />
      <Route path="/curriculo/:curriculumId/modulos" component={Login} />
      <Route path="/modulo/:moduleId/disciplinas" component={Login} />
    </Fragment>
  </Router>
);

export default App;

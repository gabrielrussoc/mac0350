import React, { Fragment } from 'react';
import { BrowserRouter as Router, Route } from 'react-router-dom';

import Curriculums from './Curriculums'
import Home from './Home'
import Login from './Login'
import SignUp from './SignUp'
import Disciplines from './Disciplines'
import Tracks from './Tracks'
import Modules from './Modules'
import Dashboard from './StudentDashboard';

const AppRouter = () => (
  <Router>
    <Fragment>
      <Route exact path="/" component={Home} />
      <Route path="/login" component={Login} />
      <Route path="/cadastro" component={SignUp} />
      <Route path="/dashboard" component={Dashboard} />
      <Route path="/curriculos" component={Curriculums} />
      <Route path="/curriculo/:curriculumId/trilhas" component={Tracks} />
      <Route path="/trilha/:TrackId" component={Modules} />
      <Route path="/modulo/:moduleId" component={Disciplines} />
    </Fragment>
  </Router>
);

export default AppRouter;

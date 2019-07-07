import React, { FunctionComponent } from 'react'
import { Link } from 'react-router-dom';

const Home: FunctionComponent = () => (
  <div className="flex justify-center items-center bg-near-white vh-100">
    <div className="bg-white br3 pv5 ph6">
      <h1 className="tc">MAC0350 (EP03)</h1>
      <div className="flex justify-between items-center pa2">
        <div className="w-50">
          <Link to="/login">
            <button className="bg-blue br3 ph3 white-90 pointer">
              <p>Login</p>
            </button>
          </Link>
        </div>
        <div className="w-50">
          <Link to="/login">
            <button className="bg-blue br3 ph3 white-90 pointer">
              <p>Cadastro</p>
            </button>
          </Link>
        </div>
      </div>
    </div>
  </div>
)

export default Home
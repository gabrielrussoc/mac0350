import React from 'react'
import { Link } from 'react-router-dom';

const Navbar = () => (
  <nav className="dt w-100 border-box pa3 ph5-ns bg-light-gray fixed">
    <div className="dtc v-mid w-75 tr">
      <Link
        to="/login"
      >
        <p className="link dim dark-gray f6 f5-ns dib mr3 mr4-ns">
          Login
        </p>
      </Link>
      <a
        className="link dim dark-gray f6 f5-ns dib mr3 mr4-ns"
        href="#services"
        title="Services"
      >
        Serviços
        </a>
      <Link
        to="/login"
      >
        <div className="link dim dark-gray f6 f5-ns dib">
          <button
            className="pa2 br2 pointer bg-transparent"
            style={{ color: `#${274060}`, borderColor: `#${274060}` }}
          >
            Login
          </button>
        </div>
      </Link>
    </div>
  </nav>
)

export default Navbar
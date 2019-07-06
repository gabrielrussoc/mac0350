import React, { FunctionComponent } from 'react'

import CardGrid from './components/CardGrid'

const cur = [
  { link: '/curriculo/45', text: 'BCC - 45' },
  { link: '/curriculo/46', text: 'BCC - 46' },
  { link: '/curriculo/47', text: 'BCC - 47' },
  { link: '/curriculo/48', text: 'BCC - 48' },
  { link: '/curriculo/49', text: 'BCC - 49' },
  { link: '/curriculo/40', text: 'BCC - 40' },
  { link: '/curriculo/41', text: 'BCC - 41' },
  { link: '/curriculo/42', text: 'BCC - 42' },
  { link: '/curriculo/43', text: 'BCC - 43' },
  { link: '/curriculo/44', text: 'BCC - 44' },
]

const Curriculums: FunctionComponent = () => (
  <div className="bg-near-white pa5 w-100">
    <div className="w-90 center">
      <div className="flex-ns items-baseline w-90 w-80-ns center mb8">
        <h1 className="c-base t-heading-1 pr7">Currículos</h1>
        <nav>
          <ul className="flex-ns list t-heading-5 pl0">
            <li className="pr6 pb4 pb0-ns">
              <a
                className="no-underline dim"
              >
                Módulos
                </a>
            </li>
            <li>
              <a
                className="no-underline dim"
              >
                Disciplinas
                </a>
            </li>
          </ul>
        </nav>
      </div>
      <div className="bg-white center">
        <CardGrid content={cur} />
      </div>
    </div>
  </div>
)

export default Curriculums
import React, { FunctionComponent } from 'react'

import Card from './components/Card'

const cur = [
  { route: '/curriculo/045', text: 'BCC045' },
  { route: '/curriculo/046', text: 'BCC046' },
  { route: '/curriculo/047', text: 'BCC047' },
]

const Curriculums: FunctionComponent = () => (
  <div className="bg-near-white vh-100 flex flex-column justify-center items-center">
    <h1>Currículos</h1>
    <div className="flex justify-around">
      {cur.map((curr) => (
        <Card content={curr} />
      ))}
    </div>
  </div>
)

export default Curriculums
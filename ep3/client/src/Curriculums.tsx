import React, { FunctionComponent, useState, useEffect } from 'react'
import axios from 'axios'

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

const Curriculums: FunctionComponent = () => {

  const [disciplines, setDisciplines] = useState(null)

  useEffect(() => {
    axios(
      `http://localhost:5000/curriculum/`, {
        headers: { 'Authorization': `Bearer ${localStorage.getItem('userToken')}` },
      }
    ).then((res) => {
      console.log(res.data)
      return (
        setDisciplines(res.data)
      )
    }).catch((err) => console.log(err))
  });

  return (
    <div className="bg-near-white pa5 w-100">
      <div className="w-90 center">
        <div className="flex-ns items-baseline w-90 w-80-ns flex justify-between center mb8">
          <h1 className="c-base t-heading-1 pr7">Currículos</h1>
        </div>
        <div className="bg-white center">
          <div>
            <button>Adicionar currículo</button>
            <button>Remover currículo</button>
          </div>
          <CardGrid content={cur} />
        </div>
      </div>
    </div>
  )
}

export default Curriculums
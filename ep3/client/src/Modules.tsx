import React, { FunctionComponent, useEffect, useState } from 'react'
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

const Modules: FunctionComponent = () => {

  const [disciplines, setDisciplines] = useState(null)

  useEffect(() => {
    const paths = window.location.pathname.split('/')
    axios(
      `http://localhost:5000/curriculum/45/disciplinas`, {
        headers: { 'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE1NjI0NTMzMzksIm5iZiI6MTU2MjQ1MzMzOSwianRpIjoiMTQzNmEyZjMtNzQxYS00NDdhLWE2MTItNTkyNDUyMGViZjliIiwiZXhwIjoxNTYyNDU0MjM5LCJpZGVudGl0eSI6MywiZnJlc2giOmZhbHNlLCJ0eXBlIjoiYWNjZXNzIn0.p36FrkNWhqo3s5WAv6xDzJshaQO3kliHtdFhslwNCTg' },
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
          <h1 className="c-base t-heading-1 pr7">Módulos</h1>
        </div>
        <div className="bg-white center">
          <div>
            <button>Adicionar módulos</button>
            <button>Remover módulos</button>
          </div>
          {/* <CardGrid content={disciplines} /> */}
          <CardGrid content={cur} />
        </div>
      </div>
    </div>
  )
}

export default Modules
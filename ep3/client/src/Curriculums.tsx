import React, { FunctionComponent, useState, useEffect } from 'react'
import axios from 'axios'

import CardGrid from './components/CardGrid'

const Curriculums: FunctionComponent = () => {

  const [disciplines, setDisciplines] = useState([])

  useEffect(() => {
    axios(
      `http://localhost:5000/curriculum/`, {
        headers: { 'Authorization': `Bearer ${localStorage.getItem('userToken')}` },
      }
    ).then((res) => {
      setDisciplines(res.data.curriculums.map((cur: any) => ({ link: `/curriculo/${cur[0]}`, text: cur[2], optionText: 'Trilhas', optionLink: 'trilhas' })))
    }).catch((err) => console.log(err))
  }, []);

  return (
    <div className="bg-near-white pa5 w-100 min-vh-100">
      <div className="w-90 center">
        <div className="flex-ns items-baseline w-90 w-80-ns flex justify-between center mb8">
          <h1 className="c-base t-heading-1 pr7">Currículos</h1>
        </div>
        <div className="bg-white center flex flex-column">
          <div className="self-end flex pa4">
            <button className="mh4 ph3 br-pill">
              <p>Adicionar currículo</p>
            </button>
          </div>
          <CardGrid content={disciplines} />
        </div>
      </div>
    </div>
  )
}

export default Curriculums
import React, { FunctionComponent, useEffect, useState } from 'react'
import axios from 'axios'

import CardGrid from './components/CardGrid'

const Modules: FunctionComponent = () => {

  const [modules, setModules] = useState([])

  useEffect(() => {
    axios(
      `http://localhost:5000/curriculum/trilha/${window.location.pathname.split('/')[2]}`, {
        headers: { 'Authorization': `Bearer ${localStorage.getItem('userToken')}` },
      }
    ).then((res) => {
      setModules(res.data.modulos.map((cur: any) => ({ link: `/modulo/${cur[0]}`, text: cur[1], optionText: 'Disciplinas', optionLink: '' })))
    }).catch((err) => console.log(err))
  }, []);

  return (
    <div className="bg-near-white pa5 w-100 min-vh-100">
      <div className="w-90 center">
        <div className="flex-ns items-baseline w-90 w-80-ns flex justify-between center mb8">
          <h1 className="c-base t-heading-1 pr7">Módulos</h1>
        </div>
        <div className="bg-white center">
          <div className="self-end flex pa4">
            <button className="mh4 ph3 br-pill">
              <p>Adicionar currículo</p>
            </button>
          </div>
          <CardGrid content={modules} />
        </div>
      </div>
    </div>
  )
}

export default Modules
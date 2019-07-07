import React, { FunctionComponent, useEffect, useState } from 'react'
import axios from 'axios'

import CardGrid from './components/CardGrid'

const Tracks: FunctionComponent = () => {

  const [tracks, setTracks] = useState([])

  useEffect(() => {
    const paths = window.location.pathname.split('/')
    axios(
      `http://localhost:5000/curriculum/${paths[2]}`, {
        headers: { 'Authorization': `Bearer ${localStorage.getItem('userToken')}` },
      }
    ).then((res) => {
      console.log(res.data)
      return setTracks(res.data.trilhas.map((tri: any) => ({ link: `/trilha/${tri[0]}`, text: `${tri[1]}`, optionText: 'Módulos', optionLink: '' })))
    }).catch((err) => console.log(err))
  });

  return (
    <div className="bg-near-white pa5 w-100 min-vh-100">
      <div className="w-90 center">
        <div className="flex-ns items-baseline w-90 w-80-ns flex justify-between center mb8">
          <h1 className="c-base t-heading-1 pr7">Trilhas</h1>
        </div>
        <div className="bg-white center">
          <div className="self-end flex pa4">
            <button className="mh4 ph3 br-pill">
              <p>Adicionar currículo</p>
            </button>
          </div>
          <CardGrid content={tracks} />
        </div>
      </div>
    </div>
  )
}

export default Tracks
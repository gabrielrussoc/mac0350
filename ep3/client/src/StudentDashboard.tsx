import React, { useEffect, useState } from 'react'
import axios from 'axios'
import Modal from 'react-modal'

import useForm from './hooks/useForm'

const Dashboard = () => {

  const [done, setDone] = useState([])
  const [planned, setPlanned] = useState([])
  const [credits, setCredits] = useState([])
  const [openModal, setOpenModal] = useState(false)
  const [modalSource, setModalSource] = useState('')

  const { values, handleChange, handleSubmit } = useForm(create)

  async function create() {
    console.log(values);
    await axios.post(`http://localhost:5000/people_curriculum/disciplinas/planejadas`, {
      codigo: values.codigo
    }, { headers: { 'Authorization': `Bearer ${localStorage.getItem('userToken')}` } })
  }

  useEffect(() => {
    axios(
      `http://localhost:5000/people_curriculum/disciplinas/cursadas`, {
        headers: { 'Authorization': `Bearer ${localStorage.getItem('userToken')}` },
      }
    ).then((res) => {
      setDone(res.data)
    }).catch((err) => console.log(err))
  }, []);
  useEffect(() => {
    axios(
      `http://localhost:5000/people_curriculum/disciplinas/cursadas/creditos`, {
        headers: { 'Authorization': `Bearer ${localStorage.getItem('userToken')}` },
      }
    ).then((res) => {
      setCredits(res.data)
    }).catch((err) => console.log(err))
  }, []);
  useEffect(() => {
    axios(
      `http://localhost:5000/people_curriculum/disciplinas/planejadas`, {
        headers: { 'Authorization': `Bearer ${localStorage.getItem('userToken')}` },
      }
    ).then((res) => {
      setPlanned(res.data)
    }).catch((err) => console.log(err))
  }, []);

  return (
    <div className="bg-near-white pa5 w-100 min-vh-100 flex justify-between">
      <div className="w-40">
        <div className="flex-ns items-baseline w-90 w-80-ns flex justify-between center mb8">
          <h1 className="c-base t-heading-1 pr7">Cursadas</h1>
        </div>
        <div className="bg-white center flex flex-column">
          <div className="self-end flex pa4">
            <p>Créditos cursados: {credits}</p>
            <button className="mh4 ph3 br-pill" onClick={() => {
              setOpenModal(true)
              setModalSource('cursadas')
            }}>
              <p>Adicionar disciplina</p>
            </button>
          </div>
          <ul className="list">
            <li>
              <div className="flex justify-center items-center br3 pa4 bg-white w-75">
                <p>MAC0350</p>
              </div>
            </li>
            <li>
              <div className="flex justify-center items-center br3 pa4 bg-white w-75">
                <p>MAC0110</p>
              </div>
            </li>
          </ul>
        </div>
      </div>
      <div className="w-40">
        <div className="flex-ns items-baseline w-90 w-80-ns flex justify-between center mb8">
          <h1 className="c-base t-heading-1 pr7">Planejadas</h1>
        </div>
        <div className="bg-white center flex flex-column">
          <div className="self-end flex pa4">
            <button className="mh4 ph3 br-pill" onClick={() => {
              setOpenModal(true)
              setModalSource('cursadas')
            }}>
              <p>Adicionar disciplina</p>
            </button>
          </div>
          <ul className="list">
            <li>
              <div className="flex justify-center items-center br3 pa4 bg-white w-75">
                <p>MAC0123</p>
              </div></li>
            <li>
              <div className="flex justify-center items-center br3 pa4 bg-white w-75">
                <p>MAC0422</p>
              </div>
            </li>
          </ul>
        </div>
      </div>
      <Modal isOpen={openModal}>
        <p>Adionando disciplina</p>
        <form className="mv2 flex flex-column w-70 center" onSubmit={handleSubmit}>
          <label><p>Código da disciplina</p></label>
          <input type="text" name="codigo" onChange={handleChange} value={values.codigo} required />
          <div className="flex mt4">
            <button type="submit" className="mv2 w-20 center br-pill">
              <p>Adicionar</p>
            </button>
            <button className=" mv2 w-20 center br-pill bg-red" onClick={() => setOpenModal(false)}>
              <p>Cancelar</p>
            </button>
          </div>
        </form>
      </Modal>
    </div>
  )
}

export default Dashboard
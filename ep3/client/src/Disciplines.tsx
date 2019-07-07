import React, { FunctionComponent, useEffect, useState } from 'react'
import axios from 'axios'
import Modal from 'react-modal'

import useForm from "./hooks/useForm"
import CardGrid from './components/CardGrid'

const Disciplines: FunctionComponent = () => {

  const [disciplines, setDisciplines] = useState([])
  const [openModal, setOpenModal] = useState(false)

  useEffect(() => {
    axios(
      `http://localhost:5000/curriculum/modulo/${window.location.pathname.split('/')[2]}`, {
        headers: { 'Authorization': `Bearer ${localStorage.getItem('userToken')}` },
      }
    ).then((res) => {
      setDisciplines(res.data.disciplinas.map((cur: any) => ({
        link: '',
        text: `${cur[0]} - ${cur[1]}`,
        deleteUrl: 'curriculum/disciplina',
        deleteParam: cur[0]
      })))
    }).catch((err) => console.log(err))
  }, []);

  const { values, handleChange, handleSubmit } = useForm(create)

  async function create() {
    console.log(values);
    await axios.post('http://localhost:5000/curriculum/disciplina', {
      codigo: values.codigo,
      creditos: values.creditos,
      nome: values.nome,
      departamento: values.departamento,
      descricao: values.descricao
    })
  }

  return (
    <div className="bg-near-white pa5 w-100 min-vh-100">
      <div className="w-90 center">
        <div className="flex-ns items-baseline w-90 w-80-ns flex justify-between center mb8">
          <h1 className="c-base t-heading-1 pr7">Disciplinas</h1>
        </div>
        <div className="bg-white center flex flex-column">
          <div className="self-end flex pa4">
            <button className="mh4 ph3 br-pill" onClick={() => setOpenModal(true)}>
              <p>Adicionar disciplina</p>
            </button>
          </div>
          <CardGrid content={disciplines} />
        </div>
        <Modal isOpen={openModal}>
          <p>Adionando disciplina</p>
          <form className="mv2 flex flex-column w-70 center" onSubmit={handleSubmit}>
            <label><p>Código</p></label>
            <input type="text" name="codigo" onChange={handleChange} value={values.codigo} required />
            <label><p>Número de créditos</p></label>
            <input type="number" name="creditos" onChange={handleChange} value={values.creditos} required />
            <label><p>Nome da disciplina</p></label>
            <input type="text" name="nome" onChange={handleChange} value={values.nome} required />
            <label><p>Departamento</p></label>
            <input type="text" name="departamento" onChange={handleChange} value={values.departamento} required />
            <label><p>Descrição</p></label>
            <input type="text" name="descricao" onChange={handleChange} value={values.descricao} required />
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
    </div>
  )
}

export default Disciplines
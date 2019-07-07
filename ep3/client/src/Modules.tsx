import React, { FunctionComponent, useEffect, useState } from 'react'
import axios from 'axios'
import Modal from 'react-modal'

import useForm from "./hooks/useForm"
import CardGrid from './components/CardGrid'

const Modules: FunctionComponent = () => {

  const [modules, setModules] = useState([])
  const [openModal, setOpenModal] = useState(false)

  useEffect(() => {
    axios(
      `http://localhost:5000/curriculum/trilha/${window.location.pathname.split('/')[2]}`, {
        headers: { 'Authorization': `Bearer ${localStorage.getItem('userToken')}` },
      }
    ).then((res) => {
      setModules(res.data.modulos.map((cur: any) => ({ link: `/modulo/${cur[0]}`, text: cur[1], optionText: 'Disciplinas', optionLink: '' })))
    }).catch((err) => console.log(err))
  }, []);

  const { values, handleChange, handleSubmit } = useForm(create)

  async function create() {
    console.log(values);
    await axios.post('http://localhost:5000/curriculum/modulo', {
      codigo: values.codigo,
      nome: values.nome,
      descricao: values.descricao,
      tr_codigo: values.tr_codigo
    })
  }

  return (
    <div className="bg-near-white pa5 w-100 min-vh-100">
      <div className="w-90 center">
        <div className="flex-ns items-baseline w-90 w-80-ns flex justify-between center mb8">
          <h1 className="c-base t-heading-1 pr7">Módulos</h1>
        </div>
        <div className="bg-white center flex flex-column">
          <div className="self-end flex pa4">
            <button className="mh4 ph3 br-pill">
              <p>Adicionar módulo</p>
            </button>
          </div>
          <CardGrid content={modules} />
        </div>
        <Modal isOpen={openModal}>
          <p>Adionando módulo</p>
          <form className="mv2 flex flex-column w-70 center" onSubmit={handleSubmit}>
            <label><p>Código</p></label>
            <input type="text" name="codigo" onChange={handleChange} value={values.codigo} required />
            <label><p>Nome do módulo</p></label>
            <input type="text" name="nome" onChange={handleChange} value={values.nome} required />
            <label><p>Descrição</p></label>
            <input type="text" name="descricao" onChange={handleChange} value={values.descricao} required />
            <label><p>Código da trilha</p></label>
            <input type="text" name="tr_codigo" onChange={handleChange} value={values.tr_codigo} required />
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

export default Modules
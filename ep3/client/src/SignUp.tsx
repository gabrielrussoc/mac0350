import React, { FunctionComponent, useState } from 'react'
import useForm from "./hooks/useForm"
import axios from 'axios'
import { Redirect } from 'react-router';

const SignUp: FunctionComponent = () => {

  const { values, handleChange, handleSubmit } = useForm(signup)
  const [userIn, setUserIn] = useState(false)

  async function signup() {
    console.log(values);
    const response = await axios.post('http://localhost:5000/access_people/signup', {
      email: values.email,
      password: values.password,
      cpf: values.cpf,
      nome: values.name,
      sexo: values.gender,
      data_nascimento: values.birthdate
    })
    localStorage.setItem("userToken", response.data.jwt)
    response && setUserIn(true)
  }

  return userIn ? <Redirect to="/curriculos" /> : (
    <div className="flex justify-center items-center bg-near-white min-vh-100 pa5">
      <div className="bg-white br3 pv5 ph6">
        <h1 className="tc">Cadastro</h1>
        <form className="mv5 flex flex-column" onSubmit={handleSubmit}>
          <label><p>Nome</p></label>
          <input type="text" name="name" onChange={handleChange} value={values.name} required />
          <label><p>CPF</p></label>
          <input type="input" name="cpf" onChange={handleChange} value={values.cpf} required />
          <label><p>Data de Nascimento</p></label>
          <input type="date" name="birthdate" onChange={handleChange} value={values.birthdate} required />
          <label><p>Sexo</p></label>
          <select name="sexo" onChange={handleChange} value={values.gender} required>
            <option value="M">Masculino</option>
            <option value="F">Feminino</option>
          </select>
          <label><p>Email</p></label>
          <input type="email" name="email" onChange={handleChange} value={values.email} required />
          <label><p>Senha</p></label>
          <input type="password" name="password" onChange={handleChange} value={values.password} required />
          <button type="submit" className="mv4 br-pill pv2">
            Entrar
          </button>
        </form>
      </div>
    </div>
  )
}

export default SignUp
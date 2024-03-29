import React, { FunctionComponent, useState } from 'react'
import useForm from "./hooks/useForm"
import axios from 'axios'
import { Redirect } from 'react-router';

const Login: FunctionComponent = () => {

  const { values, handleChange, handleSubmit } = useForm(login)
  const [userIn, setUserIn] = useState(false)
  const [whereToRedirect, setWhereToRedirect] = useState('/curriculos')

  async function login() {
    console.log(values);
    const response = await axios.post('http://localhost:5000/access/login', {
      email: values.email,
      password: values.password
    })

    // const getUserInfo = await axios.post('http://localhost:5000/access_people/person', {
    //   headers: { 'Authorization': `Bearer ${response.data.jwt}` }
    // })

    // getUserInfo.data.ad_nusp || getUserInfo.data.pr_nusp ? setWhereToRedirect('/curriculos') : setWhereToRedirect('/dashboard')
    localStorage.setItem("userToken", response.data.jwt)
    response && setUserIn(true)
  }

  return userIn ? <Redirect to={whereToRedirect} /> : (
    <div className="flex justify-center items-center bg-near-white min-vh-100">
      <div className="bg-white br3 pv5 ph6">
        <h1 className="tc">Login</h1>
        <form className="mv5 flex flex-column" onSubmit={handleSubmit}>
          <label><p>Usuário</p></label>
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

export default Login
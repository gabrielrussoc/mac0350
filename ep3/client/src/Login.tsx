import React, { FunctionComponent } from 'react'

const Login: FunctionComponent = () => (
  <div className="flex justify-center items-center bg-near-white vh-100">
    <div className="bg-white br3 pv5 ph6">
      <h1 className="tc">Login</h1>
      <form className="mv5 flex flex-column">
        <p>Usuário</p>
        <input />
        <p>Senha</p>
        <input />
        <button className="mv4 br-pill pv2">
          Entrar
        </button>
      </form>
    </div>
  </div>
)

export default Login
import React, { FunctionComponent } from 'react'

const SignUp: FunctionComponent = () => (
  <div className="flex justify-center items-center bg-near-white pa5">
    <div className="bg-white br3 pv4 ph7">
      <h1 className="tc">Cadastro</h1>
      <form className="flex flex-column">
        <p>Email</p>
        <input />
        <p>Senha</p>
        <input />
        <p>CPF</p>
        <input />
        <p>Nome</p>
        <input />
        <p>Sexo</p>
        <input />
        <p>Data de nascimento</p>
        <input />
        <button className="mv4 br-pill bg-blue white-90">
          <p>Enviar</p>
        </button>
      </form>
    </div>
  </div>
)

export default SignUp
import React, { FunctionComponent, Fragment } from 'react'
import { Link } from 'react-router-dom'

interface Props {
  content: {
    link: string
    text: string
  }[]
}

const CardGrid: FunctionComponent<Props> = ({ content }) => (
  <div className="flex flex-wrap justify-center items-center w-75 center pa4">
    {content.map((item) => (
      <Fragment>
        <div className="flex flex-column justify-center items-center br3 bg-near-white pa4 w-80 ma4">
          <p>{item.text}</p>
          <Link to={`${item.link}/trilhas`}>
            <p>Trilhas</p>
          </Link>
          <Link to={`${item.link}/modulos`}>
            <p>Módulos</p>
          </Link>
          <Link to={`${item.link}/disciplinas`}>
            <p>Disciplinas</p>
          </Link>
        </div>
      </Fragment>
    ))}
  </div>
)

export default CardGrid
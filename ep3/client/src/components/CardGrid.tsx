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
        <Link to={item.link}>
          <div className="flex justify-center items-center br3 bg-near-white pa4 w-80 ma4">
            <p>{item.text}</p>
          </div>
        </Link>
        <Link to={`${item.link}/disciplinas`}>
          <div className="flex justify-center items-center br3 bg-near-white pa4 w-80 ma4">
            <p>Disciplinas</p>
          </div>
        </Link>
        <Link to={`${item.link}/modulos`}>
          <div className="flex justify-center items-center br3 bg-near-white pa4 w-80 ma4">
            <p>Módulos</p>
          </div>
        </Link>
        <Link to={`${item.link}/trilhas`}>
          <div className="flex justify-center items-center br3 bg-near-white pa4 w-80 ma4">
            <p>Trilhas</p>
          </div>
        </Link>
      </Fragment>
    ))}
  </div>
)

export default CardGrid
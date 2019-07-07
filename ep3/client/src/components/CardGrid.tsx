import React, { FunctionComponent, Fragment } from 'react'
import { Link } from 'react-router-dom'
import axios from 'axios';

interface Props {
  content: {
    link: string
    text: string
    optionText: string
    optionLink: string
    deleteUrl: string,
    deleteParam: string
  }[]
}

const handleDelete = async (url: string, code: string) => {
  await axios.delete(`http://localhost:5000/${url}`, { data: { "code": code }, headers: { 'Authorization': `Bearer ${localStorage.getItem('userToken')}` } })
}

const CardGrid: FunctionComponent<Props> = ({ content }) => (
  <div className="flex flex-wrap justify-center items-center w-70 center pa4">
    {content.map((item) => (
      <Fragment>
        <div className="flex flex-column justify-center items-center br3 bg-near-white pa4 w-80 ma4">
          <p>{item.text}</p>
          <Link to={`${item.link}/${item.optionLink}`}>
            <p>{item.optionText}</p>
          </Link>
          <p className="link red pointer" onClick={async () => await handleDelete(item.deleteUrl, item.deleteParam)}>
            Deletar
          </p>
        </div>
      </Fragment>
    ))}
  </div>
)

export default CardGrid